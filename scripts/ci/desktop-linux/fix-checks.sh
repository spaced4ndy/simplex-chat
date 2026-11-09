#!/bin/bash

# Checks of four desktop fixes, each failing on master and passing on its fix: the channel name kept after Configure
# relays, the server test's error text, "Enter password in search" after hiding a profile, and the SimpleX Lock notice
# at a start with more than three chats.
# Usage: scripts/ci/desktop-linux/fix-checks.sh <app dir> <output dir>
# The app starts with new data and runs onboarding again (smoke-test.sh onboarding), with the update notice marked
# shown, so that only the SimpleX Lock notice can show at a start. With JACOCO, the JaCoCo directory of coverage.sh,
# the app runs with its agent, and each run's coverage is saved to COVERAGE_EXEC before the app stops. Results go to
# <output dir>/fix-checks.txt and the job summary; the script exits 0 whatever they are.

set -uo pipefail

app_dir=$1
out=$2
here=$(cd "$(dirname "$0")" && pwd)
ui=$here/ui
results=$out/fix-checks.txt
server="smp://AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=@127.0.0.1:1"
exec_dir=${COVERAGE_EXEC:-${RUNNER_TEMP:-/tmp}/coverage-exec}
runs=0
export DISPLAY=${UI_DISPLAY:-:99}
mkdir -p "$out" "$exec_dir"
: > "$results"

result() {
  echo "$1 $2" | tee -a "$results"
}

check() {
  local what=$1
  shift
  if "$@"; then
    result PASS "$what"
  else
    result FAIL "$what"
  fi
}

normalise() {
  tr -cd '[:alnum:]' <<< "$1" | tr '[:upper:]' '[:lower:]' | tr l i
}

# "x y" of the text in the left pane, x below 390: a phrase equal to it, else the first containing it; with
# "lowest", the lowest such phrase.
left_xy() {
  local target line x y text found="" lowest=""
  target=$(normalise "$1")
  while IFS= read -r line; do
    x=${line%%,*}
    y=${line#*,}
    y=${y%% *}
    text=$(normalise "${line#* }")
    [ "$x" -lt 390 ] || continue
    case "$text" in
      *"$target"*)
        found=${found:-"$x $y"}
        lowest="$x $y"
        ;;
    esac
  done < <("$ui" text)
  if [ "${2:-}" = lowest ]; then
    found=$lowest
  fi
  [ -n "$found" ] || return 1
  echo "$found"
}

window_bottom() {
  local id
  id=$(xdotool search --onlyvisible --name '^SimpleX$' | head -n 1) || return 1
  eval "$(xdotool getwindowgeometry --shell "$id")"
  echo $((Y + HEIGHT))
}

# The bottom toolbar, with the user menu at x 27 and New chat at x 363, is 730 at the first start (smoke-test.sh);
# the window can be a few pixels smaller after each restart.
toolbar_y() {
  echo $(($(window_bottom) - toolbar_offset))
}

save_coverage() {
  [ -n "${JACOCO:-}" ] || return 0
  runs=$((runs + 1))
  java -jar "$JACOCO/jacococli.jar" dump --address 127.0.0.1 --port 6300 --destfile "$exec_dir/app-$runs.exec" --quiet ||
    echo "no coverage from run $runs"
}

restart() {
  save_coverage
  "$ui" stop
  "$ui" start "$app_dir"
  sleep 8
}

channel_name_kept() {
  local x y
  "$ui" click 363 "$(toolbar_y)"
  "$ui" click-text "Create public channel" 10 || return 1
  "$ui" wait "Channel name" 10 || return 1
  read -r x y < <(left_xy "Channel name") || return 1
  "$ui" click "$x" $((y + 40))
  "$ui" type "ci name"
  "$ui" shot C1-typed
  "$ui" click-text "Configure relays" 10 || return 1
  "$ui" wait "Preset servers" 10 || return 1
  "$ui" shot C2-network
  "$ui" key Escape
  "$ui" wait "Configure relays" 10 || return 1
  sleep 2
  "$ui" shot C3-back
  left_xy "ci name" > /dev/null
}

server_error_readable() {
  local x y
  "$ui" click 27 "$(toolbar_y)"
  "$ui" click-text "Settings" 10 || return 1
  "$ui" click-text "Network" 10 || return 1
  "$ui" click-text "Your servers" 10 || return 1
  "$ui" click-text "Add server" 10 || return 1
  "$ui" click-text "Enter server manually" 10 || return 1
  "$ui" wait "Your server address" 10 || return 1
  read -r x y < <(left_xy "Your server address") || return 1
  "$ui" click 150 $((y + 60))
  "$ui" type "$server"
  "$ui" shot T1-address
  "$ui" click-text "Test server" 10 || return 1
  "$ui" wait "Server test failed" 60 || return 1
  "$ui" shot T2-alert
  "$ui" find "BROKER NETWORK connectError" > /dev/null
}

hidden_profile_notice() {
  local x y
  "$ui" click 27 "$(toolbar_y)"
  "$ui" click-text "Your chat profiles" 10 || return 1
  "$ui" click-text "Add profile" 10 || return 1
  "$ui" wait "Enter your name" 10 || return 1
  read -r x y _ < <("$ui" find "Enter your name") || return 1
  "$ui" click $((x + 90)) $((y + 40))
  "$ui" type cisecond
  "$ui" shot H1-typed
  read -r x y < <(left_xy "Create profile" lowest) || read -r x y _ < <("$ui" find "Create profile") || return 1
  "$ui" click "$x" "$y"
  sleep 3
  "$ui" key Escape
  "$ui" click 27 "$(toolbar_y)"
  "$ui" click-text "Your chat profiles" 10 || return 1
  if "$ui" wait "Don't show again" 10; then
    "$ui" click-text "Don't show again" 5
  fi
  "$ui" wait citester 10 || return 1
  read -r x y < <(left_xy citester) || return 1
  "$ui" right-click "$x" "$y"
  "$ui" click-text "Hide" 10 || return 1
  "$ui" click-text "Password to show" 10 || return 1
  "$ui" type secret12
  "$ui" click-text "Confirm password" 10 || return 1
  "$ui" type secret12
  "$ui" shot H2-form
  "$ui" click-text "Save profile password" 10 || return 1
  sleep 1
  "$ui" shot H3-after-save
  "$ui" wait "Enter password in search" 5
}

# Groups are created one at a time, each followed by a restart, until a start shows the notice: the app counts more
# than three chats after two or three groups in a new profile.
lock_notice_at_start() {
  local i x y deadline
  for i in 1 2 3 4; do
    "$ui" click 363 "$(toolbar_y)"
    "$ui" click-text "Create group" 10 || return 1
    "$ui" wait "Enter group name" 10 || return 1
    read -r x y < <(left_xy "Enter group name") || return 1
    "$ui" click 195 $((y + 40))
    "$ui" type "grp$i"
    "$ui" click-text "Create group" 10 || return 1
    "$ui" click-text "Skip inviting members" 10 || true
    "$ui" key Escape
    restart
    deadline=$((SECONDS + 30))
    while [ "$SECONDS" -lt "$deadline" ]; do
      if "$ui" find "SimpleX Lock" > /dev/null 2>&1; then
        "$ui" shot "L-notice-after-grp$i"
        "$ui" click-text "Cancel" 5
        return 0
      fi
      sleep 2
    done
    "$ui" shot "L-start-after-grp$i"
  done
  return 1
}

export UI_OUT=$out
"$ui" stop
export UI_STATE=${RUNNER_TEMP:-/tmp}/ui-fix-checks
mkdir -p "$UI_STATE/config/simplex"
printf '%s\n' NetworkSMPProxyMode=Unknown DeveloperTools=true LogLevel=DEBUG AppUpdateNoticeShown=true > "$UI_STATE/config/simplex/settings.properties"
if [ -n "${JACOCO:-}" ]; then
  export UI_JAVA_OPTIONS="-javaagent:$JACOCO/jacocoagent.jar=output=tcpserver,address=127.0.0.1,port=6300,includes=chat.simplex.*"
fi
if ! "$here/smoke-test.sh" "$app_dir" "$out" onboarding; then
  result FAIL "onboarding before the checks"
  exit 0
fi
toolbar_offset=$(($(window_bottom) - 730))

check "the channel name stays after Configure relays" channel_name_kept
restart
check "the server test's alert shows BROKER NETWORK connectError" server_error_readable
restart
check "hiding a profile shows Enter password in search" hidden_profile_notice
restart
check "the SimpleX Lock notice shows at a start with more than three chats" lock_notice_at_start
"$ui" shot final
save_coverage
"$ui" stop

if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  {
    echo "### Fix checks"
    echo
    sed 's/^/- /' "$results"
  } >> "$GITHUB_STEP_SUMMARY"
fi
exit 0
