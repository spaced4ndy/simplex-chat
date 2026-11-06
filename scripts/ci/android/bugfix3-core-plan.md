# Plan: the chat list's filters and dates, and opening a chat with unread messages

The cases run in the table's order and build on each other. A reviewer compares the screenshots of runs before and after a change: take every shot the plan names, exactly when it says, and in the record write what the shot shows, as the case asks.

For the chat list cases, the record lists the rows from the top of the list to the bottom, each with its date or time as shown, and the filter chips shown near the search field (such as "Contacts", "Groups", "Notes", "Add list"). `ui key BACK` until the chat list shows; it has a "Start new chat" button. Read the date of each row from the picture and the text. The list may be drawn from the bottom up, with the toolbar at the bottom: say which row is next to the toolbar. If the app's cards take the screen, scroll the list to see all its rows, and take one more shot named after the case with `-rows`.

A peer's chat name for the app is `citester`. **Connect to a peer by link:** `peer <name> link` prints a link; `ui open-link '<the link>'`; tap the button that opens the chat ("Open new chat"); in the chat tap its connect button ("Connect"); then `peer <name> wait 30`. If the chat doesn't show the contact as connected, run `peer <name> wait 30` again, at most 3 times.

**Create a group:** "Start new chat" → "Create group"; tap the field "Enter group name", type the name, tap "Create group"; tap "Skip" when the next screen offers it.

**A row's menu in the chat list:** long-press the row (`ui long-press <x> <y>`); it offers actions such as "Clear", "Delete" and "Mark read".

## The filters

| ID | Do | Expect |
|---|---|---|
| F1 | On the chat list after onboarding: `ui shot F1-fresh`. | The list has "Private notes" only. Record the chips shown. |
| F2 | Create the group `grpone`. `ui key BACK` until the chat list shows, without restarting. `peer alice wait 5` (it creates the peer alice too). `ui shot F2-group-created`. | The chips include "Groups". Record bug if "Groups" is missing. |
| F3 | Connect to the peer alice by link. `ui key BACK` until the chat list shows. `ui shot F3-contact-added`. | The chips include "Contacts". Record bug if "Contacts" is missing. |
| F4 | Tap the chip "Groups" (if it is missing, record blocked and go on). `ui shot F4-filter-groups`. Tap it again to clear the filter. | The list shows only "grpone" while the filter is on. |
| F5 | Open the row menu of "grpone", "Delete", and confirm. `ui key BACK` until the chat list shows. `peer alice wait 5`. `ui shot F5-group-deleted`. | The chip "Groups" is gone, as there are no more groups. Record bug if it stays. |
| F6 | Create the group `grptwo`. `ui key BACK` until the chat list shows. `peer alice wait 5`. `ui shot F6-second-group`. Then `ui relaunch`, `ui shot F6-after-restart`. | "Groups" shows in both shots. Record bug if it is missing from the first. |

## The dates

| ID | Do | Expect |
|---|---|---|
| D1 | Connect to the peer bob by link. `peer bob send '@citester' 'bob one'`, `peer bob wait 10`, then `peer alice send '@citester' 'alice one'`, `peer alice wait 10`. `ui key BACK` until the chat list shows. `ui shot D1-list`. | Every row shows today's time. |
| D2 | `peer alice group club`, `peer alice invite '#club' '@citester'`, `peer alice wait 20`. On the chat list, not opening anything: `ui shot D2-invited-live`. | The row "club" shows today's time, not 01/01/70. Record its position. |
| D3 | `ui relaunch`. `ui shot D3-invited-after-restart`. | The row "club" shows today's time, not 01/01/70, and stays on the newer side of the rows of older chats. Record bug otherwise, with its date and position. |
| D4 | Open "club" (its chat shows "Tap Join group" and a "Join group" button). `ui shot D4-invited-chat`. `ui key BACK` until the chat list shows. `ui shot D4-back-on-list`. | The row "club" still shows today's time. |
| D5 | Open "club", tap the "Join group" button. `peer alice wait 30`. `ui shot D5-joined`. Back on the chat list: `ui shot D5-joined-list`. | The row "club" shows today's time. |
| D6 | Open the row menu of "bob", "Clear", and confirm. `ui shot D6-cleared-live`. Then `ui relaunch`, `ui shot D6-cleared-after-restart`. | The row "bob" shows a time of today, not 01/01/70, and keeps its position. Record bug otherwise. |
| D7 | Open the row menu of "club", "Clear", and confirm. `ui relaunch`. `ui shot D7-group-cleared-after-restart`. | The row "club" shows a time of today, not 01/01/70. Record bug otherwise. |
| D8 | `peer bob send '@citester' 'bob two'`, `peer bob wait 10`. `ui shot D8-new-message`. | The row "bob" shows "bob two" with today's time. |

## Opening a chat with unread messages

`peer <name> many '@citester' <count>` sends messages numbered "message 1 of <count>" and so on. In each case the record gives the topmost and the bottommost message text fully visible in the chat, and whether the first unread message is on screen.

| ID | Do | Expect |
|---|---|---|
| U1 | Connect to the peer carol by link. `peer carol many '@citester' 17`, `peer carol wait 10`. Open "carol", scroll to its end (`ui scroll 540 1200 down 12`). `ui key BACK` to the chat list. `peer carol many '@citester' 13`, `peer carol wait 10`. The row "carol" shows 13 unread. Tap the row. `ui shot U1-opened` at once, then `peer carol wait 5`, `ui shot U1-later`. | "message 1 of 13" (the first unread) is on screen, with the messages before it above it. Record bug if it is below the view or further away. |
| U2 | Scroll "carol" to its end. `ui key BACK` to the chat list. `peer carol many '@citester' 5`, `peer carol wait 10`. Tap the row "carol". `ui shot U2-opened`. | "message 1 of 5" is on screen. |
| U3 | Scroll "carol" to its end. `ui key BACK` to the chat list. `peer carol many '@citester' 40`, `peer carol wait 10`. Tap the row "carol". `ui shot U3-opened`. | "message 1 of 40" is on screen, near the top of the view, and the view isn't at the end of the chat. |
| U4 | Connect to the peer dave by link. `ui key BACK` to the chat list. `peer dave many '@citester' 30`, `peer dave wait 10`. Tap the row "dave". `ui shot U4-opened`. | "message 1 of 30" is on screen. |

Record a case ok when its shots are taken and its Expect holds, and bug when it doesn't, with what you saw; the reviewer decides from the screenshots in either case.
