# Plan: chat row dates

The cases run in the table's order and build on each other. A reviewer compares the screenshots of runs before and after a change: take every shot the plan names, exactly when it says, and in the record write what the shot shows, as the case asks. Record a case ok when its shots are taken and its Expect holds, and bug when it doesn't, with what you saw; the reviewer decides from the screenshots in either case.

For each chat list shot, the record lists the rows from the top of the list to the bottom, each with its date or time as shown. The chat list is in the left pane; press Escape until it shows. Read the date of each row from the picture.

A peer's chat name for the app is `citester`. **Connect to a peer by link:** `peer <name> link` prints a link; follow "Join by a link a peer printed"; when a chat opens with a "Connect" button, click it; then `peer <name> wait 30`. If the chat doesn't show the contact as connected, run `peer <name> wait 30` again, at most 3 times.

| ID | Do | Expect |
|---|---|---|
| D1 | Connect to the peer alice by link, then to the peer bob by link. `peer bob send '@citester' 'bob one'`, `peer bob wait 10`, then `peer alice send '@citester' 'alice one'`, `peer alice wait 10`. Press Escape until the chat list shows. `ui shot D1-list`. | Every row shows today's time. |
| D2 | `peer alice group club`, `peer alice invite '#club' '@citester'`, `peer alice wait 20`. On the chat list, not opening anything: `ui shot D2-invited-live`. | The row "club" shows today's time, not 01/01/70. |
| D3 | `ui relaunch`, wait for the chat list. `ui shot D3-invited-after-restart`. | The row "club" shows today's time, not 01/01/70. Record bug otherwise, with its date. |
| D5 | Open "club", click the "Join group" button. `peer alice wait 30`. `ui shot D5-joined`. Back on the chat list: `ui shot D5-joined-list`. | The row "club" shows today's time. |
| D6 | Open the row menu of "bob", "Clear", and confirm. `ui shot D6-cleared-live`. Then `ui relaunch`, wait for the chat list, `ui shot D6-cleared-after-restart`. | The row "bob" shows a time of today, not 01/01/70, in both shots. Record bug otherwise. |
| D7 | Open the row menu of "club", "Clear", and confirm. `ui relaunch`, wait for the chat list, `ui shot D7-group-cleared-after-restart`. | The row "club" shows a time of today, not 01/01/70. Record bug otherwise. |
| D8 | `peer bob send '@citester' 'bob two'`, `peer bob wait 10`. `ui shot D8-new-message`. | The row "bob" shows "bob two" with today's time. |
