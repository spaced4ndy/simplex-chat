# Device test plan: the chat list's filters and dates

The app as the scripted smoke test leaves it: the profile "citester", without conversations. The cases run in the table's order and build on each other. A reviewer compares the screenshots of runs before and after a change: take every shot the plan names, exactly when it says, and in the record write what the shot shows, as the case asks.

For the chat list cases, the record lists the rows from the top of the list to the bottom, each with its date or time as shown, and the list tags shown above the search field (such as "Contacts", "Groups", "Notes", "Add list"). The list is drawn from the bottom up, with the toolbar at the bottom: say which row is next to the search field. Read the date of each row from the tree and the screenshot. Close sheets by swiping them down and go back with the navigation back buttons until the chat list shows.

A peer's chat name for the app is `citester`. **Connect to a peer by link:** `peer <name> link` prints a link; `ui open-link '<the link>'`; tap "Open new chat"; in the chat tap its connect button ("Connect"); then `peer <name> wait 30`. If the chat doesn't show the contact as connected, run `peer <name> wait 30` again, at most 3 times.

**Create a group:** "Compose" → "Create group"; `ui tap-value "Enter group name…"`, type the name, check the field's value, tap "Create group"; tap "Skip" when the next screen offers it.

**A row's actions:** swipe the row to the left (`ui swipe 370 <y> 60 <y>`): it offers actions such as "Delete" and "Clear", or "More" with them. Confirm in the alert that follows.

| ID | Do | Expect |
|---|---|---|
| F1 | On the chat list at the start: `ui shot F1-fresh`. | The list has "Private notes" only, or onboarding pages. Record the tags shown. |
| F2 | Create the group `grpone`. Go back until the chat list shows, without relaunching. `peer alice wait 5` (it creates the peer alice too). `ui shot F2-group-created`. | The tags include "Groups". Record bug if "Groups" is missing. |
| F3 | Connect to the peer alice by link. Go back until the chat list shows. `ui shot F3-contact-added`. | The tags include "Contacts". Record bug if "Contacts" is missing. |
| F4 | Tap the tag "Groups" (if it is missing, record blocked and go on). `ui shot F4-filter-groups`. Tap it again to clear the filter. | The list shows only "grpone" while the filter is on. |
| F5 | Delete the row "grpone" with its actions. Go back until the chat list shows. `peer alice wait 5`. `ui shot F5-group-deleted`. | The tag "Groups" is gone, as there are no more groups. Record bug if it stays. |
| F6 | Create the group `grptwo`. Go back until the chat list shows. `peer alice wait 5`. `ui shot F6-second-group`. Then `ui relaunch`, `ui shot F6-after-restart`. | "Groups" shows in both shots. Record bug if it is missing from the first. |
| D1 | Connect to the peer bob by link. `peer bob send '@citester' 'bob one'`, `peer bob wait 10`, then `peer alice send '@citester' 'alice one'`, `peer alice wait 10`. Go back until the chat list shows. `ui shot D1-list`. | Every row shows today's time. |
| D2 | `peer alice group club`, `peer alice invite '#club' '@citester'`, `peer alice wait 20`. On the chat list, not opening anything: `ui shot D2-invited-live`. | The row "club" shows today's time, not 01/01/70. Record its position. |
| D3 | `ui relaunch`. `ui shot D3-invited-after-restart`. | The row "club" shows today's time, not 01/01/70, and stays on the newer side of the rows of older chats. Record bug otherwise, with its date and position. |
| D4 | Open "club" (its chat shows "Tap Join group" and a "Join group" bar). `ui shot D4-invited-chat`. Go back until the chat list shows. `ui shot D4-back-on-list`. | The row "club" still shows today's time. |
| D5 | Open "club", tap the "Join group" bar. `peer alice wait 30`. `ui shot D5-joined`. Back on the chat list: `ui shot D5-joined-list`. | The row "club" shows today's time. |
| D6 | Clear the row "bob" with its actions ("Clear conversation?" → "Clear"). `ui shot D6-cleared-live`. Then `ui relaunch`, `ui shot D6-cleared-after-restart`. | The row "bob" shows a time of today, not 01/01/70, and keeps its position. Record bug otherwise. |
| D7 | Clear the row "club" with its actions. `ui relaunch`. `ui shot D7-group-cleared-after-restart`. | The row "club" shows a time of today, not 01/01/70. Record bug otherwise. |
| D8 | `peer bob send '@citester' 'bob two'`, `peer bob wait 10`. `ui shot D8-new-message`. | The row "bob" shows "bob two" with today's time. |

Record a case ok when its shots are taken and its Expect holds, and bug when it doesn't, with what you saw; the reviewer decides from the screenshots in either case.
