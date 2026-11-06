# Plan: contact preferences, About, the chat banner, live messages and channel members

These cases capture what the app shows, for a reviewer who compares the screenshots of runs before and after a change. Take every shot the plan names, exactly when it says, with nothing covering the part it shows (no keyboard, no alert unless the case says so). In each `record` note quote what you saw: the labels and values from the tree. Record a case ok when its shots are taken and its Expect holds, and bug when its Expect does not hold, with what you saw; the reviewer decides from the screenshots in either case. Do not run a case recorded bug a second time, even when `record` suggests it: go on to the next case.

## How to do things

- **Connect the app to a link a peer printed** (a 1-time link or an address): `ui clipboard '<the link>'`, tap "Compose", "Scan / Paste link", "Tap to paste link"; if iOS asks to allow pasting, tap "Allow Paste". An alert offers "Open new chat" (or "Open group", "Open channel"): tap it. The chat opens, not yet connected, with a bar at the bottom ("Connect", "Join group", "Join channel"). Go back to the chat list afterwards with the back button at the top left of the chat.
- **The chat banner** is the card with the chat's name and picture at the top of the chat's messages. Its last line says what the chat is, for example "Tap Connect to chat" or "Your contact". `ui find` reads it; if the chat has many items, scroll up to it with `ui swipe 200 300 200 700`.
- **Contact info:** tap the contact's name at the top of the chat (`ui find <name>`, the element with the smallest y, with `ui tap-xy`). It opens a sheet with the buttons "search", "call", "video" and "mute" under the name; close it by swiping it down (`ui swipe 200 100 200 800`). "call" isn't a button in the tree: tap its text with `ui tap-xy`.
- **Contact preferences:** the row "Contact preferences" in contact info. Each feature has a section with the feature's name as its header ("Message reactions", "Voice messages", "Audio/video calls", ...) and a picker row "You allow" showing the value, for example "default (yes)", "yes", "always" or "no". Several rows have the label "You allow", so tap the one under the section you mean with `ui tap-xy`; a menu lists the values. Scroll with `ui swipe 200 700 200 300`. "Save and notify contact" is at the end of the list. The back button leaves the screen; it asks "Save preferences?" only when there are unsaved changes: this plan always saves first.
- **Chat preferences of the profile:** open the picker with your profile image (`Image "Account"`), "Chat preferences". Each feature has a picker row with its name and a value ("always", "yes", "no"). "Save (and notify contacts)" is at the end of the list. Close it by swiping it down.
- **Sending a live message:** in a chat with an empty message field, the button with the lightning at the right end of the field (find it with `ui tree`) starts it; the first time an alert "Live message!" asks: tap "Send". Then type with `ui type`. The send button becomes a check mark: tapping it finishes the message.
- **Creating a channel:** "Compose" → "Create public channel" → `ui tap-value "Enter channel name…"`, type the name (check the value in the tree) → tap the "Create public channel" button (the list row, not the title; use `ui tap-xy` if the label is ambiguous) → wait up to 120 s for "Channel link"; if "%d/%d relays active" stays below the total for 120 s with at least 1 active, tap "Continue" and "Continue" in the alert → on "Channel link" tap "Continue" (top right). The channel opens as its chat.

## Contact preferences after "Allow calls?"

The contact pala is used only in these cases.

| ID | Do | Expect |
|---|---|---|
| P1 | `peer pala link`. Connect the app to the link, tap "Connect" in the chat, `peer pala wait 30`. `ui wait "e2e encryption" 60` (run `peer pala wait 30` once more if it isn't there), then contact info → "Contact preferences": `ui shot P1-prefs-start`. | The contact is connected; the "Audio/video calls" section's "You allow" shows "default (yes)". |
| P2 | In "Audio/video calls" choose "You allow" → "no". Tap "Save and notify contact", wait 3 s, `ui shot P2-prefs-saved`. Go back, close the sheet. | "You allow" shows "no" for "Audio/video calls". |
| P3 | Open contact info again. Tap "call": the alert "Allow calls?" shows: `ui shot P3-alert`. Tap "Allow", wait 3 s. Stay in this sheet: tap "Contact preferences", scroll to "Audio/video calls": `ui shot P3-prefs-after-allow`. Quote its "You allow" value. | The value is "yes". |
| P4 | On the same screen, in "Message reactions" choose "You allow" → "no". Scroll to "Audio/video calls": `ui shot P4-prefs-edited`. Tap "Save and notify contact", wait 3 s, `ui shot P4-prefs-saved`. Go back, close the sheet, `peer pala wait 15`, `ui shot P4-chat`. Open contact info again, "Contact preferences": `ui shot P4-prefs-reopened`, and scroll to "Audio/video calls": `ui shot P4-prefs-reopened-calls`. Quote both "You allow" values. Go back, close the sheet, go back to the chat list. | "Message reactions" is "no" and "Audio/video calls" is still "yes". |

## About, opened from Settings

| ID | Do | Expect |
|---|---|---|
| A1 | Open the picker, "Settings", scroll to "About SimpleX Chat", tap it: `ui shot A1-about`, `ui find "Why SimpleX"`. | The screen shows the link "Why SimpleX is built." |
| A2 | Tap "Why SimpleX is built.": `ui shot A2-why`. Close the sheet by swiping it down: `ui shot A2-back-on-about`. Go back to Settings with a swipe from the left edge (`ui swipe 2 400 300 400`): `ui shot A2-settings`. Close Settings. If A1 shows no link, record A2 blocked and only do the back swipe and its shot. | "You were born without an account" shows, with no button at its end; after closing it, About shows again; the swipe leaves About. |

## The chat banner after connecting

Take each shot with the banner on screen; when `ui find` doesn't list its line, scroll up to it first.

| ID | Do | Expect |
|---|---|---|
| C1 | `peer cona link`. Connect the app to the link: in the chat, before tapping "Connect": `ui shot C1-before`. Tap "Connect", `peer cona wait 30`, `ui wait "e2e encryption" 60` (run `peer cona wait 30` once more if it isn't there), `ui shot C1-connected`, `ui find "Tap Connect"`. Wait 20 s with `peer cona wait 20`, `ui shot C1-later`. Go back to the chat list, open the chat again: `ui shot C1-reopened`. | Before: the banner says "Tap Connect to chat". After connecting, in both shots, it says "Your contact", without reopening. |
| C2 | `peer conb address`, `peer conb auto-accept on`. Connect the app to the address: `ui shot C2-before`. Tap "Connect", `peer conb wait 30`, `ui wait "e2e encryption" 60` (run `peer conb wait 30` once more if it isn't there), `ui shot C2-connected`, `ui find "Tap Connect"`. Go back to the chat list, open the chat again: `ui shot C2-reopened`. | Before: the banner says "Tap Connect to send request". After connecting it says "Your contact", without reopening. |
| C5 | Open the chat with pala. `peer cone link`, then `peer pala send '@citester' '<the link>'`. In the chat with pala, tap the link in pala's message: an alert offers "Open new chat": tap it. The new chat opens: `ui shot C5-before`. Tap "Connect", `peer cone wait 30`, `ui wait "e2e encryption" 60` (run `peer cone wait 30` once more if it isn't there), `ui shot C5-connected`, `ui find "Tap Connect"`. Go back to the chat list. | Before: the banner shows the name cone and says "Tap Connect to chat", not pala's name. After connecting it says "Your contact" with the name cone, without reopening. |
| C3 | `peer hostg group club`, `peer hostg group-link club`: it prints the link. Connect the app to the link: `ui shot C3-before`. Tap "Join group", then `peer hostg wait 30`, and once more `peer hostg wait 30` until `peer hostg members club` shows citester connected. `ui shot C3-joined`, `ui find "Tap Join"`. Go back to the chat list, open the chat again: `ui shot C3-reopened`. | Before: the banner says "Tap Join group". After joining it says "Group", without reopening. |

## "Allow" and default preferences

The contact palb is used only in these cases.

| ID | Do | Expect |
|---|---|---|
| Q1 | Chat preferences of the profile: "Audio/video calls" → "no", tap "Save (and notify contacts)", close. `peer palb link`. Connect the app to the link, tap "Connect", `peer palb wait 30`, `ui wait "e2e encryption" 60` (run `peer palb wait 30` once more if it isn't there). Contact info → "Contact preferences": `ui shot Q1-prefs-top`, scroll down: `ui shot Q1-prefs-end`. Quote every "You allow" value. Go back, close the sheet. | Every "You allow" picker reads "default (…)"; "Audio/video calls" reads "default (no)". |
| Q2 | Open contact info. Tap "call", the alert "Allow calls?", tap "Allow", wait 3 s. Close the sheet. Open contact info again, "Contact preferences": `ui shot Q2-prefs-top`, scroll down: `ui shot Q2-prefs-end`. Quote every "You allow" value. Go back, close the sheet. | "Audio/video calls" reads "yes"; every other picker still reads "default (…)". |
| Q3 | Chat preferences of the profile: "Message reactions" → "no", tap "Save (and notify contacts)", close. Open contact info, "Contact preferences": `ui shot Q3-prefs-top`. Quote the "Message reactions" value. Go back, close the sheet, go back to the chat list. | "Message reactions" reads "default (no)": the profile's change applies to this contact. |

## "LIVE" on a finished live message

| ID | Do | Expect |
|---|---|---|
| L1 | Open the chat with pala. Start a live message, `ui type "live hello world"`, wait 5 s with `peer pala wait 5`: `ui shot L1-live`, `ui find LIVE`. | The message shows in the chat with the header "LIVE". |
| L2 | Tap the check mark: `ui shot L2-finished`, `ui find LIVE`. Wait 10 s with `peer pala wait 10`: `ui shot L2-finished-later`, `ui find LIVE`. Go back to the chat list, open the chat again: `ui shot L2-reopened`, `ui find LIVE`. Go back to the chat list. | In all three shots the message shows without "LIVE". |

## A channel member's verified shield

| ID | Do | Expect |
|---|---|---|
| M1 | Create the channel `ci shield`. Channel info (tap the channel's name at the top of the chat) → "Channel link" → "Share link" → in the share sheet tap "Copy" (`ui find Copy`; if it is not in the tree, `ui tap-xy` at its position in the screenshot) → close the sheet. `ui clipboard` prints the link. `peer subx connect '<the link>'`, `peer subx wait 30`, and `peer subx wait 30` once more. Go back to channel info. | The chat "ci shield" opened; `peer subx chats` lists the channel. |
| M2 | Channel info → "Subscribers": `ui shot M2-list`. The list shows subx (if it doesn't, go back, `peer subx wait 30`, and open the list again, at most 3 times). | The row of subx shows no shield. |
| M3 | Tap the row of subx. Wait for "Verify security code" (up to 20 s), tap it: `ui shot M3-code`. Tap "Mark verified": `ui shot M3-verified`. Tap the back button once, to the member's info: `ui shot M3-info`. Tap the back button once more, to the list: `ui shot M3-list-now` at once. | The info says "View security code". |
| M4 | Wait 5 s with `peer subx wait 5`: `ui shot M4-list-later`. Say whether a shield shows left of "subx" in M3-list-now and in M4-list-later, from the pictures. Go back to channel info, open "Subscribers" again: `ui shot M4-list-reopened`. Close the channel's info and go back to the chat list. | The shield shows in M3-list-now, M4-list-later and M4-list-reopened. |

## The banner when joining a channel

| ID | Do | Expect |
|---|---|---|
| C4 | Open the picker, "Your chat profiles", "Add profile", `ui tap-value "Enter your name…"`, type `cisub` (check the value), "Create profile"; close "Your chat profiles" by swiping it down. `ui clipboard '<the channel link from M1>'`. Connect the app to the link: an alert offers "Open channel": tap it: `ui shot C4-before`. Tap "Join channel", `ui wait "you are subscriber" 120`, `ui shot C4-joined`, `ui find "Tap Join"`. Go back to the chat list, open the chat again: `ui shot C4-reopened`. | Before: the banner says "Tap Join channel". After joining it says "Channel", without reopening. |
