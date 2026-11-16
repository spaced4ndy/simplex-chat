#!/bin/bash

# Starts the desktop app on a virtual display and runs the scripted UI cases with the ui helper: onboarding to the
# chat list, a local group, then the chat list with the toolbar at the bottom (the default) and at the top, then
# tests/fixtures/test.jpg and logo-large-rgba.png picked in the file dialog and sent in the group.
# Usage: scripts/ci/desktop-linux/smoke-test.sh <app dir> <output dir> [start|onboarding|layouts|setup|backend|leave-group]
# With "start" it stops at the first screen, for an agent to go on from; with "onboarding", at the chat list.
# "setup" creates the group, makes the test SMP server (backend.sh) the one that resolves SimpleX names, and stops;
# "backend" does the same, connects to the name that backend.sh registered, and goes on to both layouts.
# Both need NAMES_SERVER, the test SMP server's address.
# Each step saves a numbered screenshot and the text read from it to the output dir, prints the text to the log,
# and adds a line to steps.log there. What the screens show is checked without stopping: every check is listed in
# checks.txt and the job summary, and the test fails at the end if any failed. The app keeps running for later
# steps of the job, which get UI_OUT.

set -euo pipefail

app_dir=$1
export UI_OUT=$2
cases=${3:-layouts}
case "$cases" in
  start | onboarding | layouts | setup | backend | leave-group) ;;
  *)
    echo "error: unknown case \"$cases\": start, onboarding, layouts (the default), setup, backend or leave-group"
    exit 1
    ;;
esac
# backend.sh registered seeded.testing for ci_contact
name_label=seeded
local_chat="seeded notes"
ui=$(dirname "$0")/ui
checks=$UI_OUT/checks.txt
leave_results=$UI_OUT/leave-results.txt
# switches are at the right of the left pane, where Settings open
switch_x=335
fixtures=$(cd "$(dirname "$0")/../../../tests/fixtures" && pwd)
state=${UI_STATE:-${RUNNER_TEMP:-/tmp}/ui}
compose_y=730
paperclip_x=415
message_x=700
compose_area=976x200+390+500
mkdir -p "$UI_OUT"
: > "$checks"
if [ -n "${GITHUB_ENV:-}" ]; then
  echo "UI_OUT=$UI_OUT" >> "$GITHUB_ENV"
fi

report_checks() {
  [ -s "$checks" ] || return 0
  echo "::group::checks"
  cat "$checks"
  echo "::endgroup::"
  if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
    {
      echo "### Smoke test checks"
      echo
      sed 's/^/- /' "$checks"
    } >> "$GITHUB_STEP_SUMMARY"
  fi
}

finish() {
  local status=$?
  if [ "$status" -ne 0 ]; then
    "$ui" shot final || true
  fi
  echo "::group::app log, last 300 lines"
  tail -n 300 "$UI_OUT/app.log" || true
  echo "::endgroup::"
  report_checks
  exit "$status"
}
trap finish EXIT

fail() {
  echo "error: $*"
  exit 1
}

check() {
  local what=$1
  shift
  if "$@"; then
    echo "PASS $what" | tee -a "$checks"
  else
    echo "FAIL $what" | tee -a "$checks"
    echo "::error::$what"
  fi
}

# Fails when any check failed, else prints what the case showed.
passed() {
  if grep -q '^FAIL' "$checks"; then
    fail "the smoke test failed checks: $(grep -c '^FAIL' "$checks") of $(grep -cE '^(PASS|FAIL)' "$checks")"
  fi
  echo "smoke test passed: $1"
}

# Prints yes when the command succeeds, else no.
yes_no() {
  if "$@" > /dev/null; then
    echo yes
  else
    echo no
  fi
}

# text compared as ui compares it: letters and digits, lowercase, a lowercase l read as i
normalise() {
  tr -cd '[:alnum:]' <<< "$1" | tr '[:upper:]' '[:lower:]' | tr l i
}

# Prints "x y" of the text in the chat list pane, left of x 390: a phrase equal to it, else, unless the second argument
# is "exact", the first containing it. The chats, results and Settings are there; the right pane shows the open chat,
# which can have the same names.
left_pane_position() {
  pane_position 0 390 "$@"
}

# The same right of the chat list, in the open chat and group info; the chat's name is in its banner and, lower, its toolbar.
right_pane_position() {
  pane_position 390 1440 "$@"
}

# Prints "x y" of the text from x $1 to $2 as above, or with "lowest" of the lowest phrase containing it; $5: a shot's text.
pane_position() {
  local from=$1 to=$2 target line x y found=""
  target=$(normalise "$3")
  while IFS= read -r line; do
    x=${line%%,*}
    y=${line#*,}
    y=${y%% *}
    [ "$x" -ge "$from" ] && [ "$x" -lt "$to" ] || continue
    case "$(normalise "${line#* }")" in
      "$target")
        if [ "${4:-}" != lowest ]; then
          echo "$x $y"
          return 0
        fi
        found="$x $y"
        ;;
      *"$target"*)
        found=${found:-"$x $y"}
        [ "${4:-}" != lowest ] || found="$x $y"
        ;;
    esac
  done < <(if [ -n "${5:-}" ]; then cat "$5"; else "$ui" text; fi)
  [ -n "$found" ] && [ "${4:-}" != exact ] || return 1
  echo "$found"
}

on_screen() {
  left_pane_position "$1" > /dev/null
}

not_on_screen() {
  ! left_pane_position "$1" > /dev/null
}

y_of() {
  local pos
  pos=$(left_pane_position "$1") || return 1
  cut -d ' ' -f 2 <<< "$pos"
}

above() {
  local a b
  a=$(y_of "$1") || return 1
  b=$(y_of "$2") || return 1
  [ "$a" -lt "$b" ]
}

# the value is on the same line as its setting's title
in_line_with() {
  local value title
  value=$(y_of "$1") || return 1
  title=$(y_of "$2") || return 1
  [ $((value - title)) -lt 10 ] && [ $((title - value)) -lt 10 ]
}

# Scrolls the left pane down until the text shows above its bottom toolbar.
scroll_to() {
  local y
  for _ in 1 2 3 4 5 6 7 8; do
    if y=$(y_of "$1") && [ "$y" -lt 640 ]; then
      return 0
    fi
    "$ui" scroll 195 400 down
  done
  return 1
}

# Escape closes one screen at a time, and clears the search field
back_to_chat_list() {
  for _ in 1 2 3 4 5 6; do
    on_chat_list && return 0
    "$ui" key Escape
  done
  on_chat_list
}

# New chat has the same search field
on_chat_list() {
  not_on_screen "Settings" && not_on_screen "Chat preferences" && not_on_screen "Network" && not_on_screen "New chat" && on_screen "Search or paste SimpleX link"
}

# Opens Settings from the user menu, behind the profile picture at the left of the bottom toolbar.
open_settings() {
  "$ui" click 27 730
  "$ui" click-text "Settings" 10
}

# Turns "Reachable app toolbars" off in Settings > Appearance, which moves the toolbar and the search field to the top.
use_top_toolbar() {
  local y
  "$ui" key Escape
  open_settings
  "$ui" click-text "Appearance" 10
  "$ui" wait "Reachable app toolbars" 10
  "$ui" shot appearance
  y=$(y_of "Reachable app toolbars")
  "$ui" click "$switch_x" "$y"
  "$ui" shot appearance-toolbar-switched
  back_to_chat_list || true
  "$ui" shot top-chat-list
  y=$(y_of "Search or paste SimpleX link") || fail "no search field after closing Settings"
  [ "$y" -lt 200 ] || fail "the search field is still at the bottom (y $y) after switching Reachable app toolbars"
}

# The search field and "Add list" next to it: at the bottom of the chat list, "Add list" above the field; at the top, below it.
check_layout() {
  local layout=$1 field
  field=$(y_of "Search or paste SimpleX link") || field=""
  "$ui" shot "$layout-layout"
  check "$layout: \"$local_chat\" listed" on_screen "$local_chat"
  if [ "$layout" = bottom ]; then
    check "bottom: the search field is at the bottom" [ "${field:-0}" -gt 600 ]
    check "bottom: \"Add list\" above the search field" above "Add list" "Search or paste SimpleX link"
  else
    check "top: the search field is at the top" [ "${field:-900}" -lt 200 ]
    check "top: \"Add list\" below the search field" above "Search or paste SimpleX link" "Add list"
  fi
}

# A group of the user's own: without chats the chat list shows no search field.
create_local_chat() {
  local name=$1 y
  # the pencil at the right of the bottom toolbar opens New chat
  "$ui" click 363 730
  "$ui" click-text "Create group" 10
  "$ui" wait "Enter group name" 10
  y=$(y_of "Enter group name")
  "$ui" click 195 $((y + 40))
  "$ui" type "$name"
  "$ui" shot new-group
  "$ui" click-text "Create group" 10
  "$ui" click-text "Skip inviting members" 10 || true
  "$ui" shot group-created
  "$ui" key Escape
  back_to_chat_list || fail "no chat list after creating the group"
  # the group stays open in the right pane: Escape doesn't close a chat on desktop
  on_screen "$name" || fail "\"$name\" is not in the chat list"
  "$ui" shot local-chat
}

# Clicks a server role's value until its dropdown shows. The menu is open when an item reads exactly "yes", which no
# role's value does ("default (yes)", "default (no)", "no"); it can take longer to show than OCR takes to read the screen.
open_role_menu() {
  for _ in 1 2 3; do
    "$ui" click-text "$1" 10 || return 1
    for _ in 1 2 3; do
      left_pane_position yes exact > /dev/null && return 0
      sleep 1
    done
  done
  return 1
}

# Settings > Network & servers: the test SMP server added with the names role, and names off for the preset
# operators, so that only the test server resolves names.
use_names_server() {
  local x y operator
  open_settings
  # OCR reads "Network & servers" as two phrases
  "$ui" click-text "Network" 10
  "$ui" click-text "Your servers" 10
  "$ui" click-text "Add server" 10
  "$ui" click-text "Enter server manually" 10
  "$ui" wait "Your server address" 10
  y=$(y_of "Your server address")
  "$ui" click 195 $((y + 50))
  "$ui" type "$NAMES_SERVER"
  y=$(y_of "Use for new connections")
  "$ui" click "$switch_x" "$y"
  "$ui" shot new-server
  "$ui" key Escape
  # the New server screen shows the address with "127.0.0.1" too, until it closes
  "$ui" wait "Add server" 10
  "$ui" wait "Test servers" 10
  "$ui" click-text "127.0.0.1" 10
  "$ui" wait "SMP server" 10
  scroll_to "To resolve names" || fail "no \"To resolve names\" in the test server's settings"
  # A dropdown opens from its value; a custom server's roles default to yes, yes and no, so the first "default (yes)"
  # is the receiving one. A directory service can't reply to queues on this server, so it only resolves names.
  open_role_menu "default (yes)" || fail "no menu for the test server's \"To receive\""
  # OCR misreads the short "no", the item after "yes"
  read -r x y < <(left_pane_position yes exact) || fail "the \"To receive\" menu closed"
  "$ui" click "$x" $((y + 48))
  open_role_menu "default (no)" || fail "no menu for the test server's \"To resolve names\""
  read -r x y < <(left_pane_position yes exact) || fail "the \"To resolve names\" menu closed"
  "$ui" click "$x" "$y"
  "$ui" shot names-server-roles
  # the first "default (yes)" and the first "yes" are on the lines after "To receive", so it is no
  in_line_with "default (yes)" "For private routing" || fail "the test server's \"To receive\" is still its default"
  in_line_with "yes" "To resolve names" || fail "the test server's \"To resolve names\" is not yes, or \"To receive\" is"
  "$ui" key Escape
  "$ui" wait "Add server" 10
  "$ui" key Escape
  for operator in "SimpleX Chat" Flux; do
    "$ui" click-text "$operator" 10
    # the operator's own toggle: the title "<operator> servers" can wrap
    "$ui" wait "Use servers" 10
    scroll_to "To resolve names" || fail "no \"To resolve names\" in the $operator settings"
    y=$(y_of "To resolve names")
    "$ui" click "$switch_x" "$y"
    "$ui" shot "names-off-$(tr -cd 'a-zA-Z' <<< "$operator")"
    "$ui" key Escape
    "$ui" wait "Your servers" 10
  done
  scroll_to "Save servers" || fail "no \"Save servers\" in Network & servers"
  "$ui" click-text "Save servers" 10
  sleep 2
  "$ui" shot servers-saved
  back_to_chat_list || fail "no chat list after saving the servers"
}

# A bare name in the search field is offered with the .testing domain; the test SMP server resolves it to ci_contact's
# address, and the app shows that profile before connecting.
connect_by_name() {
  "$ui" click-text "Search or paste SimpleX link"
  "$ui" type "$name_label"
  "$ui" wait "Connect to $name_label.testing" 15
  "$ui" shot name-typed
  "$ui" click-text "Connect to $name_label.testing"
  check "$name_label.testing resolves to ci_contact" "$ui" wait ci_contact 60
  check "the app offers to open a new chat with ci_contact" "$ui" wait "Open new chat" 10
  "$ui" shot name-resolved
  "$ui" click-text Cancel 10 || "$ui" key Escape
  back_to_chat_list || fail "no chat list after the name's alert"
}

sent_files() {
  find "$state/data" -name "IMG_*.$1" | wc -l
}

sent_file() {
  local deadline=$((SECONDS + 30))
  until [ "$(sent_files "$1")" -gt "$2" ]; do
    [ "$SECONDS" -lt "$deadline" ] || return 1
    sleep 1
  done
}

latest_shot() {
  find "$UI_OUT" -maxdepth 1 -name "[0-9][0-9]-$1.png" | sort | tail -n 1
}

compose_changed() {
  local changed
  convert "$(latest_shot "$1")" -crop "$compose_area" +repage "$UI_OUT/compose-$1.png"
  convert "$(latest_shot "$2")" -crop "$compose_area" +repage "$UI_OUT/compose-$2.png"
  changed=$(compare -metric AE -fuzz 10% "$UI_OUT/compose-$1.png" "$UI_OUT/compose-$2.png" null: 2>&1 || true)
  changed=${changed%% *}
  echo "pixels changed above the message field: $changed"
  [ "${changed%%.*}" -gt 2000 ]
}

core_returned_no_image() {
  grep -c "core returned no image" "$UI_OUT/app.log" || true
}

send_image() {
  local file=$1 ext=$2 sent no_image x y
  sent=$(sent_files "$ext")
  no_image=$(core_returned_no_image)
  "$ui" shot "before-$ext"
  "$ui" click "$paperclip_x" "$compose_y"
  "$ui" click-text Image 10
  "$ui" wait "File Name" 20
  "$ui" shot "file-dialog-$ext"
  read -r x y _ < <("$ui" find "File Name")
  "$ui" click $((x + 250)) "$y"
  "$ui" type "$fixtures/$file"
  "$ui" key Return
  sleep 3
  "$ui" shot "preview-$ext"
  check "$ext: the compose area shows the picked image" compose_changed "before-$ext" "preview-$ext"
  "$ui" click "$message_x" "$compose_y"
  "$ui" key Return
  check "$ext: the image is sent as a .$ext file" sent_file "$ext" "$sent"
  "$ui" shot "sent-$ext"
  check "$ext: the core resized the image" [ "$(core_returned_no_image)" -eq "$no_image" ]
}

send_images() {
  local x y
  read -r x y < <(left_pane_position "$local_chat") || fail "no \"$local_chat\" in the chat list"
  "$ui" click "$x" "$y"
  send_image test.jpg jpg
  send_image logo-large-rgba.png png
}

# Scrolls group info, right of the chat, until "Clear chat" leaves room below for "Delete group" and "Leave group".
info_to_end() {
  local y
  for _ in 1 2 3 4; do
    "$ui" scroll 1170 400 down 10
    if read -r _ y < <(right_pane_position "Clear chat") && [ "$y" -lt 560 ]; then
      return 0
    fi
  done
  return 1
}

# Opens group info by clicking the chat's name in its toolbar, at the bottom of the chat, and scrolls it to its end.
open_group_info() {
  local x y
  read -r x y < <(right_pane_position "$1" lowest) || fail "no \"$1\" in the chat's toolbar"
  "$ui" click "$x" "$y"
  info_to_end || fail "no \"Clear chat\" at the end of group info"
}

# Leaves a new group from its group info and adds to leave-results.txt what group info and the message field show then.
leave_group_try() {
  local n=$1 name=$2 x y txt leave delete you_left
  create_local_chat "$name"
  read -r x y < <(left_pane_position "$name") || fail "no \"$name\" in the chat list"
  "$ui" click "$x" "$y"
  open_group_info "$name"
  "$ui" shot "leave-$n-before"
  "$ui" click-text "Leave group" 10
  "$ui" wait "You will stop" 10
  "$ui" shot "leave-$n-alert"
  read -r x y < <(pane_position 0 1440 Leave exact) || fail "no \"Leave\" in the alert"
  "$ui" click "$x" "$y"
  sleep 3
  if "$ui" find "You will stop" > /dev/null 2>&1; then
    fail "the alert is still open after \"Leave\""
  fi
  if right_pane_position "Clear chat" > /dev/null; then
    info_to_end || fail "no \"Clear chat\" at the end of group info"
  else
    open_group_info "$name"
  fi
  "$ui" shot "leave-$n-info"
  txt=$(latest_shot "leave-$n-info")
  txt=${txt%.png}.txt
  leave=$(yes_no right_pane_position "Leave group" "" "$txt")
  delete=$(yes_no right_pane_position "Delete group" "" "$txt")
  "$ui" key Escape
  sleep 1
  if right_pane_position "Clear chat" > /dev/null; then
    fail "group info is still open after Escape"
  fi
  "$ui" shot "leave-$n-chat"
  txt=$(latest_shot "leave-$n-chat")
  txt=${txt%.png}.txt
  you_left=$(yes_no pane_position "$paperclip_x" "$message_x" "you left" "" "$txt")
  echo "try $n: leave-group-offered=$leave delete-group-offered=$delete compose-you-left=$you_left" >> "$leave_results"
}

# Ten tries in new groups: a try whose step fails records "error", and the next one goes on.
leave_group_tries() {
  local n status bug fixed errors summary fix words=(one two three four five six seven eight nine ten)
  fix="leave-group-offered=no delete-group-offered=[a-z]* compose-you-left=yes"
  : > "$leave_results"
  for n in $(seq 10); do
    set +e
    (
      set -e
      leave_group_try "$n" "trial ${words[n - 1]}"
    )
    status=$?
    set -e
    if [ "$status" -ne 0 ]; then
      echo "try $n: error" >> "$leave_results"
      "$ui" key Escape Escape || true
    fi
    back_to_chat_list || true
    check "try $n: after leaving, group info offers no \"Leave group\" and the message field reads \"you left\"" grep -qx "try $n: $fix" "$leave_results"
  done
  bug=$(grep -cE "leave-group-offered=yes|compose-you-left=no" "$leave_results" || true)
  fixed=$(grep -cx "try [0-9]*: $fix" "$leave_results" || true)
  errors=$(grep -c ": error$" "$leave_results" || true)
  summary="leave group: $bug of 10 tries show the bug (\"Leave group\" still offered or the message field not \"you left\"), $fixed show the fix, $errors could not complete"
  echo "$summary"
  if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
    {
      echo "### Leave group"
      echo
      echo "$summary"
      echo
      sed 's/^/- /' "$leave_results"
    } >> "$GITHUB_STEP_SUMMARY"
  fi
}

# private routing to unknown servers only: the preset servers that would proxy name lookups can't reach the test SMP
# server on 127.0.0.1; developer tools at the debug level put the app's debug log in app.log
"$ui" start "$app_dir" NetworkSMPProxyMode=Unknown DeveloperTools=true LogLevel=DEBUG

# onboarding to the chat list
"$ui" wait "Create your profile" 180
"$ui" shot first-screen
if [ "$cases" = start ]; then
  echo "smoke test: the app shows its first screen"
  exit 0
fi
"$ui" click-text "Create your profile"

"$ui" wait "Create profile" 30
"$ui" click-text "Enter profile name"
"$ui" type citester
"$ui" shot profile-name
"$ui" click-text "Create profile"

# a new desktop database gets a random passphrase, which onboarding offers to replace
"$ui" wait "Use random passphrase" 60
"$ui" shot database-passphrase
"$ui" click-text "Use random passphrase"
"$ui" wait "OK" 10
"$ui" shot random-passphrase-alert
"$ui" click-text "OK"

"$ui" wait "Continue" 60
"$ui" shot your-network
"$ui" click-text "Continue"

"$ui" wait "Accept" 30
"$ui" shot network-commitments
"$ui" click-text "Accept"

"$ui" wait "Talk to someone" 60
sleep 3
"$ui" shot chat-list
if [ "$cases" = onboarding ]; then
  echo "smoke test passed: onboarding reached the chat list"
  exit 0
fi

if [ "$cases" = leave-group ]; then
  leave_group_tries
  passed "after leaving a group, group info offered no \"Leave group\" and the message field read \"you left\" in all 10 tries"
  exit 0
fi

create_local_chat "$local_chat"
if [ "$cases" = setup ] || [ "$cases" = backend ]; then
  : "${NAMES_SERVER:?NAMES_SERVER must be the test SMP server address}"
  use_names_server
  if [ "$cases" = setup ]; then
    echo "smoke test setup done: \"$local_chat\" created, $NAMES_SERVER resolves names"
    exit 0
  fi
  connect_by_name
fi

check_layout bottom
use_top_toolbar
check_layout top
send_images

passed "onboarding reached the chat list, which shows \"$local_chat\" with the toolbar at the bottom and at the top"
