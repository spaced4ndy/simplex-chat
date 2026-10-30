#!/bin/bash

# Watches the badges screen while its page changes, over and over, and checks that the screen draws the page its
# accessibility tree lists: Your badge, Issuing your badge or Support SimpleX. Both ways of changing it need test builds:
# - console, the default: the chat console's /badge test_cycles <cycles> <seconds without a badge> <seconds with one>
#   makes the core credit a prepaid badge and let it lapse;
# - purchase (BADGE_CYCLES_MODE=purchase): each cycle buys one month through the app's test products, which shows
#   Issuing your badge until the core credits the test purchase, then the badge lapses.
# This script reinstalls the app, takes it through onboarding and opens Settings > Supporter perks.
# BADGE_CYCLES_SETTINGS, settings as ui start takes them, restarts the app with them first.
# Every reading keeps its screenshot, tree and text in <output dir>/readings, and readings.log has the page the tree
# lists and the page the screenshot shows, read by OCR: blank when the middle of the screen is one colour (ink below
# MIN_INK), unread when OCR finds no page, uncarded when Your badge is drawn without its cards. A change of the listed page is a transition; it fails when a reading after
# its first (which can be taken mid-change) draws another page or nothing. transitions.log has each one.
# Usage: scripts/ci/android/badge-cycles.sh <apk> <output dir> [cycles] [seconds without] [seconds with]

set -euo pipefail

apk=$1
out=$2
cycles=${3:-40}
hidden_secs=${4:-10}
shown_secs=${5:-10}
min_ink=${MIN_INK:-0.02}
mode=${BADGE_CYCLES_MODE:-console}
package=chat.simplex.app
here=$(dirname "$0")
ui=$here/ui
readings=$out/readings
mkdir -p "$readings"

# uninstalled rather than cleared: a cleared app loses the permissions install granted, and onboarding then asks differently
fresh_onboarding() {
  UI_OUT=$out "$ui" stop
  adb uninstall "$package"
  "$here/smoke-test.sh" "$apk" "$out/$1" onboarding
}

# the ARM translation can crash the app at start (README, "Known limits"), so onboarding gets a second start
fresh_onboarding onboarding || fresh_onboarding onboarding-again
export UI_OUT=$out
if [ -n "${BADGE_CYCLES_SETTINGS:-}" ]; then
  "$ui" stop
  # shellcheck disable=SC2086
  "$ui" start "$apk" $BADGE_CYCLES_SETTINGS
  "$ui" wait "Start new chat" 90
fi

normalise() {
  tr -cd '[:alnum:]' <<< "$1" | tr '[:upper:]' '[:lower:]'
}

# the page a text shows: issuing, support, badge or none; the issuing title and the store's "Choose your badge" on the
# support page both contain "your badge", so those two are checked first
page_of_text() {
  local text
  text=$(normalise "$1")
  case "$text" in
    *"$(normalise "Issuing your badge")"*) echo issuing ;;
    *"$(normalise "Get a badge to send")"*) echo support ;;
    *"$(normalise "Your badge")"* | *"$(normalise "shown on your profile")"*) echo badge ;;
    *) echo none ;;
  esac
}

# Prints "<page> <ink> <margin>": the page OCR reads on the screenshot, or blank when the spread of grey levels between
# the bars, which ImageMagick reads as nan when there is none, is below MIN_INK, or unread. Your badge is drawn on the
# grey of a card screen: its left margin reads white (margin above 0.98) only when it was drawn without its cards.
drawn_page_of() {
  local w h ink margin page
  read -r w h < <(identify -format '%w %h\n' "$1")
  ink=$(convert "$1" -alpha off -crop "${w}x$((h * 6 / 10))+0+$((h * 15 / 100))" +repage -colorspace Gray -format '%[fx:standard_deviation]' info:)
  margin=$(convert "$1" -alpha off -crop "$((w * 3 / 100))x$((h * 25 / 100))+$((w / 200))+$((h * 30 / 100))" +repage -colorspace Gray -format '%[fx:mean]' info:)
  case "$ink" in *nan*) ink=0 ;; esac
  page=$(page_of_text "$(tesseract "$1" stdout 2> /dev/null)")
  if [ "$page" = none ]; then
    if awk -v ink="$ink" -v min="$min_ink" 'BEGIN { exit !(ink < min) }'; then page=blank; else page=unread; fi
  elif [ "$page" = badge ] && awk -v margin="$margin" 'BEGIN { exit !(margin > 0.98) }'; then
    page=uncarded
  fi
  echo "$page $ink $margin"
}

open_settings() {
  "$ui" click-text "profile image placeholder" 10
  "$ui" click-text "Settings" 10
}

scroll_to_click() {
  for _ in 1 2 3 4 5 6; do
    "$ui" click-text "$1" 3 && return 0
    "$ui" scroll 540 1400 down 1
  done
  return 1
}

# Settings lists the app's version and code at its end, which open the screen with Developer tools; that screen shows
# the version too, but not followed by the code
gradle_properties=$here/../../../apps/multiplatform/gradle.properties
app_version="$(sed -n 's/^android.version_name=//p' "$gradle_properties") ($(sed -n 's/^android.version_code=//p' "$gradle_properties"))"

back_to_settings() {
  for _ in 1 2 3 4 5 6; do
    "$ui" find "$app_version" > /dev/null 2>&1 && return 0
    "$ui" key BACK
  done
  "$ui" find "$app_version" > /dev/null
}

scroll_up_to_click() {
  for _ in 1 2 3 4 5 6 7 8; do
    "$ui" click-text "$1" 3 && return 0
    "$ui" scroll 540 1000 up 1
  done
  return 1
}

# the slowed app can drop typed characters (README, "Known limits"), so a field that lost some is cleared and typed again
type_command() {
  local keys=()
  "$ui" type "$1" && return 0
  for _ in $(seq ${#1}); do keys+=(DEL); done
  "$ui" key MOVE_END "${keys[@]}"
  "$ui" type "$1"
}

start_cycles() {
  local x y
  open_settings
  scroll_to_click "$app_version"
  "$ui" click-text "Developer tools" 10
  "$ui" click-text "Chat console" 10
  read -r x y < <("$ui" tree | sed -n -E 's/^EditText .* at ([0-9]+),([0-9]+) size ([0-9]+)x([0-9]+).*/\1 \2 \3 \4/p' | awk '{ print $1 + int($3 / 2), $2 + int($4 / 2); exit }')
  "$ui" click "$x" "$y"
  type_command "/badge test_cycles $cycles $hidden_secs $shown_secs"
  "$ui" click-text "Send Message" 10
  "$ui" wait "test_cycles" 10
  "$ui" shot cycles-started
  back_to_settings
}

# one month through the test products: Support SimpleX > Choose your badge > Supporter > 1 month > Pay
buy_badge() {
  "$ui" click-text "Choose your badge" 10
  "$ui" click-text "Continue" 10
  "$ui" click-text "1 month" 10
  "$ui" click-text "Continue" 10
  "$ui" click-text "Pay \$7.00" 10
}

if [ "$mode" = purchase ]; then
  open_settings
  scroll_to_click "Supporter perks"
else
  start_cycles
  scroll_up_to_click "Supporter perks"
fi
"$ui" shot badges-open

pages=0
transitions=0
failed=0
blank=0
listed_before=""
listed_now=""
since=""
drawn_since_first=""

# Judges the page listed since the last change: the first is the screen as it opened, not a transition, and one read
# once has nothing to judge.
judge_transition() {
  local verdict=ok drawn
  [ -n "$listed_now" ] || return 0
  pages=$((pages + 1))
  [ "$listed_now" != none ] || verdict=unlisted
  for drawn in $drawn_since_first; do
    if [ "$drawn" = blank ]; then
      verdict=blank
    elif [ "$drawn" != "$listed_now" ] && [ "$verdict" = ok ]; then
      verdict="drew another page"
    fi
  done
  echo "$since ${listed_before:-opened}>$listed_now: $verdict, drawn:$drawn_since_first" >> "$out/transitions.log"
  [ "$pages" -gt 1 ] || return 0
  transitions=$((transitions + 1))
  [ "$verdict" = ok ] || failed=$((failed + 1))
  [ "$verdict" != blank ] || blank=$((blank + 1))
}

n=0
listed=""
read_screen() {
  local reading now drawn ink margin
  n=$((n + 1))
  reading=$readings/$(printf '%04d' "$n")
  UI_OUT=$reading "$ui" shot reading > /dev/null
  listed=$(page_of_text "$(cut -d ' ' -f 2- "$reading/01-reading.txt")")
  read -r drawn ink margin <<< "$(drawn_page_of "$reading/01-reading.png")"
  mv "$reading" "$reading-$listed-$drawn"
  now=$(date -u +%H:%M:%S)
  echo "$now reading $n: listed $listed, drawn $drawn, ink $ink, margin $margin" >> "$out/readings.log"
  if [ "$listed" != "$listed_now" ]; then
    judge_transition
    listed_before=$listed_now
    listed_now=$listed
    since=$now
    drawn_since_first=""
  else
    drawn_since_first+=" $drawn"
  fi
}

# a purchase cycle reads until the badge has come and gone, and three readings of Support SimpleX judge its return
read_purchase_cycle() {
  local seen_badge="" support_after=0 started=$SECONDS
  while [ $((SECONDS - started)) -lt 90 ] && [ "$support_after" -lt 3 ]; do
    read_screen
    [ "$listed" != badge ] || seen_badge=yes
    if [ -n "$seen_badge" ] && [ "$listed" = support ]; then support_after=$((support_after + 1)); fi
  done
}

if [ "$mode" = purchase ]; then
  for c in $(seq "$cycles"); do
    "$ui" wait "Choose your badge" 30
    buy_badge
    echo "$(date -u +%H:%M:%S) bought $c" >> "$out/readings.log"
    # the purchase screens close once the purchase is held; the badges screen under them is not composed until then
    "$ui" wait "Issuing your badge" 20 || true
    read_purchase_cycle
  done
else
  deadline=$((SECONDS + cycles * (hidden_secs + shown_secs) + 60))
  while [ "$SECONDS" -lt "$deadline" ]; do
    read_screen
  done
fi
judge_transition
"$ui" key BACK

kinds=$(sed -n 's/^[0-9:]* \([a-z]*>[a-z]*\): \([^,]*\),.*/\1 \2/p' "$out/transitions.log" | sort | uniq -c | sed 's/^ *//' | paste -sd ';' -)
summary="badge cycles ($mode): $transitions transitions on the open screen in $n readings; $failed drew another page or nothing, $blank of them nothing; by kind: $kinds"
echo "$summary"
if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  {
    echo "### Badge screen cycles${BADGE_CYCLES_SETTINGS:+ with $BADGE_CYCLES_SETTINGS}"
    echo
    echo "$summary"
  } >> "$GITHUB_STEP_SUMMARY"
fi
[ "$failed" -eq 0 ]
