# Plan: the chat list's filters and dates, and opening a chat with unread messages

The cases run in the table's order and build on each other. A reviewer compares the screenshots of runs before and after a change: take every shot the plan names, exactly when it says, and in the record write what the shot shows, as the case asks.

For the chat list cases, the record lists the rows from the top of the list to the bottom, each with its date or time as shown, and the filter chips shown above the search field (such as "Contacts", "Groups", "Notes", "Add list"). The chat list is in the left pane; press Escape until it shows. Read the date of each row from the picture.

A peer's chat name for the app is `citester`. **Connect to a peer by link:** `peer <name> link` prints a link; follow "Join by a link a peer printed"; when a chat opens with a "Connect" button, click it; then `peer <name> wait 30`. If the chat doesn't show the contact as connected, run `peer <name> wait 30` again, at most 3 times.

**Create a group:** pencil (about 363,730) → "Create group"; click the field "Enter group name", type the name, click "Create group"; click "Skip" when the next screen offers it.

## The filters

| ID | Do | Expect |
|---|---|---|
| F1 | On the chat list after onboarding: `ui shot F1-fresh`. | The list has "Private notes" only. Record the chips shown. |
| F2 | Create the group `grpone`. Press Escape until the chat list shows, without restarting. `peer alice wait 5` (it creates the peer alice too). `ui shot F2-group-created`. | The chips include "Groups". Record bug if "Groups" is missing. |
| F3 | Connect to the peer alice by link. Press Escape until the chat list shows. `ui shot F3-contact-added`. | The chips include "Contacts". Record bug if "Contacts" is missing. |
| F4 | Click the chip "Groups" (if it is missing, record blocked and go on). `ui shot F4-filter-groups`. Click it again to clear the filter. | The list shows only "grpone" while the filter is on. |
| F5 | Open the row menu of "grpone", "Delete", and confirm. Press Escape until the chat list shows. `peer alice wait 5`. `ui shot F5-group-deleted`. | The chip "Groups" is gone, as there are no more groups. Record bug if it stays. |
| F6 | Create the group `grptwo`. Press Escape until the chat list shows. `peer alice wait 5`. `ui shot F6-second-group`. Then `ui relaunch`, wait for the chat list, `ui shot F6-after-restart`. | "Groups" shows in both shots. Record bug if it is missing from the first. |

## The dates

| ID | Do | Expect |
|---|---|---|
| D1 | Connect to the peer bob by link. `peer bob send '@citester' 'bob one'`, `peer bob wait 10`, then `peer alice send '@citester' 'alice one'`, `peer alice wait 10`. Press Escape until the chat list shows. `ui shot D1-list`. | Every row shows today's time. |
| D2 | `peer alice group club`, `peer alice invite '#club' '@citester'`, `peer alice wait 20`. On the chat list, not opening anything: `ui shot D2-invited-live`. | The row "club" shows today's time, not 01/01/70. Record its position. |
| D3 | `ui relaunch`, wait for the chat list. `ui shot D3-invited-after-restart`. | The row "club" shows today's time, not 01/01/70, and stays above the rows of older chats. Record bug otherwise, with its date and position. |
| D4 | Open "club" (its chat shows "Tap Join group" and a "Join group" button). `ui shot D4-invited-chat`. Press Escape until the chat list shows, or open "Private notes" to leave it. `ui shot D4-back-on-list`. | The row "club" still shows today's time. |
| D5 | Open "club", click the "Join group" button. `peer alice wait 30`. `ui shot D5-joined`. Back on the chat list: `ui shot D5-joined-list`. | The row "club" shows today's time. |
| D6 | Open the row menu of "bob", "Clear", and confirm. `ui shot D6-cleared-live`. Then `ui relaunch`, wait for the chat list, `ui shot D6-cleared-after-restart`. | The row "bob" shows a time of today, not 01/01/70, and keeps its position. Record bug otherwise. |
| D7 | Open the row menu of "club", "Clear", and confirm. `ui relaunch`, wait for the chat list, `ui shot D7-group-cleared-after-restart`. | The row "club" shows a time of today, not 01/01/70. Record bug otherwise. |
| D8 | `peer bob send '@citester' 'bob two'`, `peer bob wait 10`. `ui shot D8-new-message`. | The row "bob" shows "bob two" with today's time. |

## Opening a chat with unread messages

`peer <name> many '@citester' <count>` sends messages numbered "message 1 of <count>" and so on. To leave a chat without opening another one you need, open "Private notes". In each case the record gives the topmost and the bottommost message text fully visible in the chat, and whether the first unread message is on screen.

| ID | Do | Expect |
|---|---|---|
| U1 | Connect to the peer carol by link. `peer carol many '@citester' 17`, `peer carol wait 10`. Open "carol", scroll to its end (`ui scroll 900 450 down 20`). Open "Private notes". `peer carol many '@citester' 13`, `peer carol wait 10`. The row "carol" shows 13 unread. Click the row. `ui shot U1-opened` at once, then `peer carol wait 5`, `ui shot U1-later`. | "message 1 of 13" (the first unread) is on screen, with the messages before it above it. Record bug if it is below the view or further away. |
| U2 | Scroll "carol" to its end. Open "Private notes". `peer carol many '@citester' 5`, `peer carol wait 10`. Click the row "carol". `ui shot U2-opened`. | "message 1 of 5" is on screen. |
| U3 | Scroll "carol" to its end. Open "Private notes". `peer carol many '@citester' 40`, `peer carol wait 10`. Click the row "carol". `ui shot U3-opened`. | "message 1 of 40" is on screen, near the top of the view, and the view isn't at the end of the chat. |
| U4 | Connect to the peer dave by link. Open "Private notes". `peer dave many '@citester' 30`, `peer dave wait 10`. Click the row "dave". `ui shot U4-opened`. | "message 1 of 30" is on screen. |
| U5 | `ui window 1100 600`, `ui shot U5-small-window`. Scroll "carol" to its end. Open "Private notes". `peer carol many '@citester' 13`, `peer carol wait 10`. Click the row "carol". `ui shot U5-opened`. `ui window 1440 900`. | "message 1 of 13" is on screen. Record bug if it is below the view or further away. |

Record a case ok when its shots are taken and its Expect holds, and bug when it doesn't, with what you saw; the reviewer decides from the screenshots in either case.
