#!/bin/bash

# Runs one session of the device test plan with Claude Code on this runner after the smoke test: the session
# CLAUDE_SESSION of claude-scope, with its layout, cases and plan. The session drives the app only through the ui, peer
# and record helpers, and reads and writes only its own directory, which ends up in <output dir>/<session>: prompt.md,
# report.md, results.tsv, shots/, transcript.jsonl (stream-json).
# It passes when the session's final message ends with "CLAUDE-TEST: PASS".
# Usage: scripts/ci/ios-sim/claude-test.sh <output dir>
# Needs CLAUDE_CODE_OAUTH_TOKEN, CLAUDE_SESSION, SIM_UDID (the booted simulator with the app) and, when the test backend
# runs, BACKEND_DIR.

set -euo pipefail

token=${CLAUDE_CODE_OAUTH_TOKEN:?CLAUDE_CODE_OAUTH_TOKEN must be set}
# only the claude processes get the token, nothing else this script starts
unset CLAUDE_CODE_OAUTH_TOKEN

mkdir -p "$1"
out=$(cd "$1" && pwd)
# sessions run here and move to the output dir, which is uploaded, only after their files are checked for the token
staging=$out.sessions
mkdir -p "$staging"
dir=$(cd "$(dirname "$0")" && pwd)
: "${SIM_UDID:?SIM_UDID must be the simulator UDID}"
name=${CLAUDE_SESSION:?CLAUDE_SESSION must be a session of claude-scope}
BACKEND_DIR=${BACKEND_DIR:-}

scope() {
  sed -n "s/^$1: *//p" "$dir/claude-scope"
}

model=$(scope model)
layout=$(scope "layout-$name")
layout=${layout:-reachable}
plan=$(scope "plan-$name")
max_turns=$(scope max-turns)
max_budget=$(scope max-budget-usd)
max_minutes=$(scope max-minutes)
: "${max_minutes:?claude-scope must set max-minutes}"

export PATH="$dir:$(dirname "$dir"):$PATH" BACKEND_DIR APP_LOG=$out/app.log CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 PLATFORM=ios
if [ -n "$BACKEND_DIR" ]; then
  cp "$BACKEND_DIR/seed.md" "$out/seed.md"
fi
settings=$out/settings.json
cat > "$settings" << EOF
{"hooks": {"PreToolUse": [{"matcher": "Bash", "hooks": [{"type": "command", "command": "$dir/claude-guard.py"}]}]}}
EOF

xcrun simctl spawn "$SIM_UDID" log stream --level debug --style compact --predicate 'process == "SimpleX"' > "$APP_LOG" 2>&1 &
log_pid=$!
trap 'kill "$log_pid" 2> /dev/null || true' EXIT

layout_name() {
  case "$1" in
    reachable) echo "the one-hand UI (reachable toolbar)" ;;
    top) echo "the top bar" ;;
  esac
}

write_prompt() {
  cat "$dir/claude-prompt.md"
  echo
  echo "## The ui commands"
  echo
  echo '```'
  ui || true
  echo '```'
  echo
  echo "## Recording results"
  echo
  echo '```'
  record
  echo '```'
  echo
  if [ -n "$BACKEND_DIR" ]; then
    echo "## The peer commands"
    echo
    echo '```'
    peer || true
    echo '```'
    echo
  fi
  echo "## This session"
  echo
  echo "- Session: $name."
  echo "- Layout: $(layout_name "$layout")."
  echo "- Cases: $(scope "cases-$name")."
  local entries
  entries=$(scope "entries-$name")
  if [ -n "$entries" ]; then
    echo "- Entries to use: $entries."
  fi
  if [ -n "$BACKEND_DIR" ]; then
    echo "- The test directory's address: $(cat "$BACKEND_DIR/directory-link")."
    echo "- Names server to add in the app: $(cat "$BACKEND_DIR/names-server")."
  else
    echo "- No test backend runs in this session."
  fi
  echo "- At the start: the smoke test onboarded a profile (typed as \"citester\"; the keyboard may have autocorrected the name) and checked the chat list in both layouts; the profile has no conversations."
  echo "- Limits: $max_turns turns, \$$max_budget (estimated at API prices) and $max_minutes minutes. Keep report.md and the results current as you go."
  echo
  if [ -n "$BACKEND_DIR" ]; then
    cat "$out/seed.md"
    echo
  fi
  cat "$dir/${plan:-device-test-plan.md}"
}

session=$staging/$name
mkdir -p "$session/shots"
echo "$name" >> "$out/sessions"
ui layout "$layout"
RESULTS=$session/results.tsv
CASES=$(scope "cases-$name")
PROMPT=$session/prompt.md
export RESULTS CASES PROMPT
write_prompt > "$session/prompt.md"
echo "::group::Claude session: $name, $layout, $model, $max_turns turns, \$$max_budget, $max_minutes minutes"
status=0
# outside the session's directory, so the session cannot change it
export CLAUDE_GUARD_LOG=$staging/$name-guard.log
: > "$CLAUDE_GUARD_LOG"
# the alarm ends claude within the session's minutes, so its files are checked and moved before the step's time limit
(
  cd "$session"
  UI_OUT=$session/shots CLAUDE_CODE_OAUTH_TOKEN=$token perl -e 'alarm shift; exec @ARGV' "$((max_minutes * 60))" claude -p \
    --model "$model" \
    --effort high \
    --restricted \
    --tools Bash,Read,Write,Edit \
    --allowedTools "Bash(ui)" "Bash(ui *)" "Bash(peer)" "Bash(peer *)" "Bash(record)" "Bash(record *)" "Read(/$session/**)" "Edit(/$session/**)" \
    --permission-mode dontAsk \
    --permission-prompts none \
    --strict-mcp-config \
    --max-turns "$max_turns" \
    --max-budget-usd "$max_budget" \
    --autocompact 200k \
    --no-session-persistence \
    --settings "$settings" \
    --output-format stream-json \
    --verbose \
    < prompt.md > transcript.jsonl 2> stderr.log
) || status=$?
echo "claude exited with $status"
# the token must never be printed or uploaded, whatever the session did; grep reads it from a pipe, not from its arguments
leak=0
grep -rqF -f <(printf '%s\n' "$token") "$session" "$CLAUDE_GUARD_LOG" || leak=$?
if [ "$leak" -ne 1 ]; then
  rm -rf "$session" "$CLAUDE_GUARD_LOG"
  echo "::error::the $name session's files contain the token, or checking for it failed (grep exited $leak), so they were deleted before the upload"
  status=1
else
  mv "$session" "$CLAUDE_GUARD_LOG" "$out/"
  session=$out/$name
  CLAUDE_GUARD_LOG=$out/$name-guard.log
  tail -n 20 "$session/stderr.log"
  if [ -f "$session/report.md" ]; then
    cat "$session/report.md"
  else
    echo "no report.md"
  fi
  cat "$session/results.tsv" 2> /dev/null || echo "no results.tsv"
  echo "guard hook: $(grep -c '^allow' "$CLAUDE_GUARD_LOG" || true) allowed, $(grep -c '^refuse' "$CLAUDE_GUARD_LOG" || true) refused"
  grep '^refuse' "$CLAUDE_GUARD_LOG" || true
  result=$(jq -r -R 'fromjson? | select(.type == "result") | .result // empty' "$session/transcript.jsonl" | tail -n 20 || true)
  echo "final message, last lines:"
  echo "$result"
  last=$(grep -v '^[[:space:]]*$' <<< "$result" | tail -n 1 || true)
  if ! grep -qxE '[*`]*CLAUDE-TEST: PASS[*`.]*[[:space:]]*' <<< "$last"; then
    echo "::error::the $name session's final message does not end with CLAUDE-TEST: PASS"
    status=1
  fi
fi
echo "::endgroup::"
exit "$status"
