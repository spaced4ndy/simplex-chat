#!/bin/bash

# Runs Claude Code for one session of claude-scope, CLAUDE_SESSION ("main" when the scope lists none), as the prompt
# (claude-test.md unless given) describes, with the session's cases and plan when the scope names them, and passes
# when its final message ends with "CLAUDE-TEST: PASS". The scope is the one next to the prompt.
# Usage: scripts/ci/desktop-linux/claude-test.sh <output dir> <transcript .jsonl> [prompt .md]
# Expects the app started (smoke-test.sh ... start), claude, ui, peer and record on PATH, CLAUDE_MODEL,
# CLAUDE_CODE_OAUTH_TOKEN, PLATFORM, and BACKEND_DIR when the test backend runs. Claude works in the session's
# directory, which moves to <output dir>/<session> once it is checked for the token: the prompt it was given, the
# screenshots, report.md and results.tsv. The transcript, Claude Code's stderr (<transcript>.stderr) and the guard
# hook's log (<transcript>.guard.log) are kept outside it, where Claude can't write. If any of them holds the token,
# all are deleted and the run fails.

set -euo pipefail

token=${CLAUDE_CODE_OAUTH_TOKEN:?CLAUDE_CODE_OAUTH_TOKEN must be set}
# only the claude process gets the token, nothing else this script starts
unset CLAUDE_CODE_OAUTH_TOKEN
here=$(cd "$(dirname "$0")" && pwd)
out=$(cd "$1" && pwd)
transcript=$2
prompt=${3:-$here/claude-test.md}
plans=$(cd "$(dirname "$prompt")" && pwd)
name=${CLAUDE_SESSION:-main}
session=$out.sessions/$name
staged=$out.sessions/$name.transcript.jsonl
settings=$(mktemp)
mkdir -p "$session/screens"
export CLAUDE_GUARD_LOG=$staged.guard.log
: > "$CLAUDE_GUARD_LOG"

scope() {
  sed -n "s/^$1: *//p" "$plans/claude-scope"
}

max_turns=$(scope max-turns)
max_budget=$(scope max-budget-usd)
max_minutes=$(scope max-minutes)
: "${max_minutes:?claude-scope must set max-minutes}"
cases=$(scope "cases-$name")
plan=$(scope "plan-$name")

export UI_OUT=$session/screens RESULTS=$session/results.tsv

{
  cat "$prompt"
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
  if [ -n "${BACKEND_DIR:-}" ]; then
    echo
    echo "## The peer commands"
    echo
    echo '```'
    peer || true
    echo '```'
  fi
  if [ -n "$cases" ]; then
    echo
    echo "## This session"
    echo
    echo "- Session: $name."
    echo "- Cases: $cases."
    echo "- Limits: ${max_turns:-60} turns, \$${max_budget:-3} (estimated at API prices) and $max_minutes minutes. Record each case's result as soon as it is done."
  fi
  if [ -n "$plan" ]; then
    echo
    cat "$plans/$plan"
  fi
} > "$session/prompt.md"

cat > "$settings" << EOF
{"hooks": {"PreToolUse": [{"matcher": "Bash", "hooks": [{"type": "command", "command": "$here/claude-guard.py"}]}]}}
EOF

claude --version
cd "$session"
status=0
# the alarm ends claude within the session's minutes, so its files are checked and moved before the step's time limit
CLAUDE_CODE_OAUTH_TOKEN=$token perl -e 'alarm shift; exec @ARGV' "$((max_minutes * 60))" claude -p \
  --model "$CLAUDE_MODEL" \
  --effort high \
  --restricted \
  --tools Bash,Read,Write,Edit \
  --allowedTools "Bash(ui)" "Bash(ui *)" "Bash(peer)" "Bash(peer *)" "Bash(record)" "Bash(record *)" "Read(/$session/**)" "Edit(/$session/**)" \
  --permission-mode dontAsk \
  --permission-prompts none \
  --strict-mcp-config \
  --max-turns "${max_turns:-60}" \
  --max-budget-usd "${max_budget:-3}" \
  --autocompact 200k \
  --no-session-persistence \
  --settings "$settings" \
  --output-format stream-json \
  --verbose \
  < prompt.md > "$staged" 2> "$staged.stderr" || status=$?

# A second safeguard to the file tools' limits: what the session wrote is printed and uploaded only when it is known
# not to hold the token. grep reads the token from a pipe, so it is in no process's arguments.
leak=0
printf '%s\n' "$token" | grep -rqF -f - -- "$session" "$staged" "$staged.stderr" "$CLAUDE_GUARD_LOG" || leak=$?
if [ "$leak" -ne 1 ]; then
  rm -rf -- "$session" "$staged" "$staged.stderr" "$CLAUDE_GUARD_LOG"
  echo "error: the token is in the Claude session's output, or checking for it failed (grep exited $leak); the output, transcript, stderr and guard log are deleted"
  exit 1
fi
mv "$session" "$out/"
session=$out/$name
mv "$staged" "$transcript"
mv "$staged.stderr" "$transcript.stderr"
mv "$CLAUDE_GUARD_LOG" "$transcript.guard.log"
CLAUDE_GUARD_LOG=$transcript.guard.log

echo "::group::claude stderr"
cat "$transcript.stderr"
echo "::endgroup::"
echo "::group::report.md"
cat "$session/report.md" 2> /dev/null || echo "no report.md"
echo "::endgroup::"
echo "::group::results.tsv"
cat "$session/results.tsv" 2> /dev/null || echo "no results.tsv"
echo "::endgroup::"
echo "::group::guard hook decisions"
cat "$CLAUDE_GUARD_LOG"
echo "::endgroup::"
result=$(jq -r 'select(.type == "result") | .result // empty' "$transcript" 2> /dev/null | tail -n 20 || true)
echo "final message, last lines:"
echo "$result"
if [ "$status" -ne 0 ]; then
  echo "error: claude exited with $status"
  exit 1
fi
last=$(grep -v '^[[:space:]]*$' <<< "$result" | tail -n 1 || true)
grep -qxE '[*`]*CLAUDE-TEST: PASS[*`.]*[[:space:]]*' <<< "$last"
