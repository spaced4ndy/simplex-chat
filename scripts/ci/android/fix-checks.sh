#!/bin/bash

# Checks of five Android fixes, each failing on master and passing on its fix: the channel name kept after Configure
# relays, the server test's error text, the QR scanner closed without a camera, "Enter password in search" after hiding
# a profile, and the SimpleX Lock notice at a start with more than three chats.
# Usage: scripts/ci/android/fix-checks.sh <apk> <output dir>
# The app's data is cleared and onboarding runs again (smoke-test.sh onboarding), so that each check starts from a
# new profile with the reachable toolbar. Results go to <output dir>/fix-checks.txt and the job summary; the script
# exits 0 whatever they are.

set -uo pipefail

apk=$1
out=$2
here=$(cd "$(dirname "$0")" && pwd)
ui=$here/ui
package=chat.simplex.app
results=$out/fix-checks.txt
server="smp://AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=@127.0.0.1:1"
mkdir -p "$out"
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

field_below() {
  local y
  y=$("$ui" find "$1" | cut -d ' ' -f 2) || return 1
  "$ui" tree | sed -n -E 's/^EditText .* at ([0-9]+),([0-9]+) size ([0-9]+)x([0-9]+).*/\1 \2 \3 \4/p' |
    awk -v y="$y" '$2 > y { print $1 + int($3 / 2), $2 + int($4 / 2); exit }'
}

launch() {
  local activity
  activity=$(adb shell cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.LAUNCHER "$package" | tail -n 1)
  adb shell am force-stop "$package"
  adb shell am start -W -n "$activity" > /dev/null
}

channel_name_kept() {
  "$ui" click-text "Start new chat" 10 || return 1
  "$ui" click-text "Create public channel" 10 || return 1
  "$ui" wait "Channel name" 10 || return 1
  "$ui" type "ci name" || return 1
  "$ui" shot C1-typed
  "$ui" click-text "Configure relays" 10 || return 1
  "$ui" wait "Network & servers" 10 || return 1
  "$ui" shot C2-network
  "$ui" key BACK
  "$ui" wait "Configure relays" 10 || return 1
  sleep 2
  "$ui" shot C3-back
  "$ui" find "ci name" > /dev/null
}

server_error_readable() {
  local x y
  "$ui" click-text "profile image placeholder" 10 || return 1
  "$ui" click-text "Settings" 10 || return 1
  "$ui" click-text "Network & servers" 10 || return 1
  "$ui" click-text "Your servers" 10 || return 1
  "$ui" click-text "Add server" 10 || return 1
  "$ui" click-text "Enter server manually" 10 || return 1
  "$ui" wait "Your server address" 10 || return 1
  read -r x y < <(field_below "Your server address") || return 1
  "$ui" click "$x" "$y"
  "$ui" type "$server" || return 1
  "$ui" click-text "Test server" 10 || return 1
  "$ui" wait "Server test failed" 60 || return 1
  "$ui" shot T2-alert
  "$ui" find "BROKER NETWORK connectError" > /dev/null
}

crashes() {
  grep -c 'SIMPLEX *: App crashed' "$UI_OUT/app.log" || true
}

# On master the main thread waits about 30 s for the camera provider before the crash alert, so the check waits 60 s,
# and reads the app's own crash line in logcat as well as the screen.
no_crash_after_scanner() {
  local before deadline
  before=$(crashes)
  "$ui" click-text "Start new chat" 10 || return 1
  "$ui" click-text "Paste link / Scan" 10 || return 1
  "$ui" wait "Or scan QR code" 10 || return 1
  "$ui" shot Q1-scanner
  "$ui" key BACK
  deadline=$((SECONDS + 60))
  while [ "$SECONDS" -lt "$deadline" ]; do
    if [ "$(crashes)" -gt "$before" ] || "$ui" find "View crashed" > /dev/null 2>&1; then
      sleep 2
      "$ui" shot Q2-crashed
      return 1
    fi
    sleep 2
  done
  "$ui" shot Q2-after-close
  "$ui" find "New chat" > /dev/null
}

hidden_profile_notice() {
  local x y deadline
  "$ui" click-text "profile image placeholder" 10 || return 1
  "$ui" click-text "Your chat profiles" 10 || return 1
  "$ui" click-text "Add profile" 10 || return 1
  "$ui" wait "Enter your name" 10 || return 1
  read -r x y < <(field_below "Enter your name") || return 1
  "$ui" click "$x" "$y"
  "$ui" type cisecond || return 1
  "$ui" click-text "Create profile" 10 || return 1
  # "Make profile private!" covers the list once there are two profiles, and a dump then shows only the alert
  deadline=$((SECONDS + 40))
  until "$ui" find "Your chat profiles" > /dev/null 2>&1; do
    if "$ui" find "Don't show again" > /dev/null 2>&1; then
      "$ui" click-text "Don't show again" 5
    fi
    [ "$SECONDS" -lt "$deadline" ] || return 1
    sleep 1
  done
  sleep 2
  if "$ui" find "Don't show again" > /dev/null 2>&1; then
    "$ui" click-text "Don't show again" 5
  fi
  "$ui" shot H1-profiles
  "$ui" wait citester 10 || return 1
  read -r x y _ < <("$ui" find citester) || return 1
  adb shell input swipe "$x" "$y" "$x" "$y" 1500
  "$ui" click-text "Hide" 10 || return 1
  "$ui" wait "Password to show" 10 || return 1
  "$ui" click-text "Password to show" 5 || return 1
  adb shell input text secret12
  "$ui" click-text "Confirm password" 5 || return 1
  adb shell input text secret12
  "$ui" shot H2-form
  "$ui" click-text "Save profile password" 10 || return 1
  "$ui" wait "Your chat profiles" 10 || return 1
  "$ui" shot H3-after-save
  "$ui" find "Enter password in search" > /dev/null
}

# Groups are created one at a time, each followed by a restart, until a start shows the notice: the app counts more
# than three chats after two or three groups in a new profile.
lock_notice_at_start() {
  local i deadline
  for i in 1 2 3 4; do
    "$ui" click-text "Start new chat" 10 || return 1
    "$ui" click-text "Create group" 10 || return 1
    "$ui" wait "Enter group name" 10 || return 1
    "$ui" type "grp$i" || return 1
    "$ui" click-text "Create group" 10 || return 1
    "$ui" wait "Invite members" 30 || return 1
    launch
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

# Onboarding as smoke-test.sh does it, after the app's data was cleared: the notifications alert then has only "OK", as
# the battery setting from the first install remains.
onboarding() {
  local deadline
  "$ui" start "$apk" NetworkSMPProxyMode=Unknown DeveloperTools=true LogLevel=DEBUG || return 1
  deadline=$((SECONDS + 180))
  until "$ui" find "Get started" > /dev/null 2>&1; do
    if "$ui" find "New in" > /dev/null 2>&1; then
      "$ui" click-text OK 5
    fi
    [ "$SECONDS" -lt "$deadline" ] || return 1
    sleep 1
  done
  "$ui" click-text "Get started" || return 1
  "$ui" click-text "Enter profile name" 30 || return 1
  "$ui" type citester || return 1
  "$ui" click-text "Create profile" || return 1
  "$ui" click-text "Continue" 60 || return 1
  deadline=$((SECONDS + 120))
  until "$ui" find "Talk to someone" > /dev/null 2>&1; do
    if "$ui" find "Allow" > /dev/null 2>&1; then
      "$ui" click-text "Allow" 5
    elif "$ui" find "Instant notifications" > /dev/null 2>&1; then
      "$ui" click-text OK 5
    elif "$ui" find "Accept" > /dev/null 2>&1; then
      "$ui" click-text "Accept" 5
    fi
    [ "$SECONDS" -lt "$deadline" ] || return 1
    sleep 1
  done
  "$ui" shot chat-list
}

export UI_OUT=$out
"$ui" stop
adb shell pm clear "$package"
export UI_STATE=${RUNNER_TEMP:-/tmp}/ui-fix-checks
mkdir -p "$UI_STATE"
if ! onboarding; then
  "$ui" shot onboarding-failed
  result FAIL "onboarding before the checks"
  exit 0
fi

check "the channel name stays after Configure relays" channel_name_kept
"$ui" relaunch
check "the server test's alert shows BROKER NETWORK connectError" server_error_readable
"$ui" relaunch
check "closing the QR scanner shows New chat and no View crashed" no_crash_after_scanner
"$ui" relaunch
check "hiding a profile shows Enter password in search" hidden_profile_notice
"$ui" relaunch
check "the SimpleX Lock notice shows at a start with more than three chats" lock_notice_at_start
"$ui" shot final

if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  {
    echo "### Fix checks"
    echo
    sed 's/^/- /' "$results"
  } >> "$GITHUB_STEP_SUMMARY"
fi
exit 0
