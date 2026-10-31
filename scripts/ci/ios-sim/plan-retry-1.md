# Release regression: iOS

## On iOS, for these cases

- In this run results go to `record`, not to a Results table: skip the Results table and the `todo` rows that "The report" above describes; `report.md` holds only the line on the app at the start, `## Findings` and `## Harness notes`.
- **Give the app a link:** `ui clipboard '<link>'`, then paste it where the case says: in the search field (tap it once to focus it, once more for its menu, then "Paste"), or "Compose" → "Scan / Paste link" → "Tap to paste link" (tap "Allow Paste" if iOS asks). `ui open-link '<link>'` opens a link as another app would.
- **Get a link from the app:** its "Copy" button, or "Share link" and "Copy" in the share sheet; then `ui clipboard` prints it.
- A message's menu: `ui long-press` on the message's text; a chat's actions in the list: swipe its row (`ui swipe`) or long-press it.
- **Peers can do much more than accept connections:** they create groups and group links, invite, join, change roles, send reactions, replies, edits, deletions, files, images, voice and live messages, and report messages; `peer` alone lists every command. Earlier sessions recorded cases `manual` saying the peers had no group, reaction or delete commands: they have them, so set such cases up with peers and run them. A group with peers: `peer alice group team`, `peer alice invite '#team' '@citester' admin` (the app accepts the invitation), then `peer alice invite '#team' '@bob'` and `peer bob join '#team'` for more members.
- **Delivery receipts:** Settings → Your privacy → More privacy → "Send delivery receipts to" (contacts, groups); a contact's or group's own setting is in its info.
- **Incognito:** on the 1-time link, address and connect screens, the profile row lets you choose Incognito.
- **A peer joins a group or channel by its link** with `peer <name> connect '<link>'`; `peer <name> join` only accepts an invitation.
- **Business chats:** `peer bob address`, then `peer bob cli '/_address_settings 1 {"businessAddress":true,"autoAccept":{"acceptIncognito":false}}'`, and connect the app to bob's address; the app's own business address is a switch in its address settings, and a peer connects to it.
- **A peer's preferences for the app:** `peer bob cli '/set voice @citester no'` (always, yes or no; also files, calls, delete, disappear). **A long chat history:** `peer bob many '@citester' 120`.
- **A live message from a peer:** `peer bob live '@citester' 'Hel'`, then `peer bob live-update '@citester' 'Hello'` as often as needed, and `peer bob live-update '@citester' 'Hello all' end` to finish it.
- **A contact that deleted the app's contact without notifying:** `peer bob delete-contact citester silent`.
- **Member reports:** the app reports from a group where it is a plain member (the message's menu, Report); the app as an admin gets one from `peer bob report '#team' carol spam '<message>'`, sent by a member peer about another member's message. A member waiting for review is rejected with `peer <admin> remove '#<group>' <member>`.
- **Passcodes:** when a case sets a passcode or a self-destruct code, choose it yourself and write it in the case's note, so later cases can use it. The simulator's device passcode prompt accepts any input.
- **Row 619:** the "invited via your group link" item is shown to the group link's owner: the app creates a group and its link, a new peer joins by it (`peer dave connect '<link>'`), and the app's group chat shows the item.
- **Row 23:** the notice offering SimpleX Lock shows at a later chat start (on iOS the second), only while the lock is off and the profile has 3 or more contacts: make 3 contacts, keep the lock off, and `ui relaunch` twice.

## The regression cases

The cases of this session (the table at the end) come from the team's release regression table: each is one line written for a person who knows the app, not a list of steps. For each case, work out the shortest way to check what it says in this app, do it, check it, and record the result at once.

No one answers questions during this session: never stop to ask, and never end it before every case of the table is recorded. Each `record` prints the next case; whenever you are unsure which cases are left or what they say, for example after the conversation was compacted, run `record` alone: it lists the cases left, with their text.

1. Read the case. Where it names a gesture of another platform ("swipe (ios) / long press (android)"), use this app's own way to do the same. A case about a version upgrade, a camera, a microphone, a call, push notifications, a second device, a purchase or a badge code is `manual`: record what it needs. Where only a part of a case needs such a thing, check the rest, and say in the note which part was not checked.
2. Set up what the case needs: contacts, groups and channel subscribers are CLI peers (below); messages, settings and profiles you make in the app.
3. Do it, and check each thing the case says. Take `ui shot <row>-<what>` at the moment that shows the result (the name has only letters, digits, - and _).
4. Record it: `record <row> <ok|bug|blocked|manual> "<what you saw, in one line>" <screenshot name>`.
   - ok: everything the case says held, as you saw it.
   - bug: the app did something wrong; the note says what you did, what you saw and what you expected.
   - blocked: this runner or a helper stopped the case (say what: the peer couldn't connect, the screen couldn't be read, the app crashed at start).
   - manual: the case needs something no runner has; say what.
5. Spend at most about 20 turns on one case: when it is stuck, record it `blocked` with what stopped it, and go on.

Run the cases in the table's order, but leave to the end any case that wipes the app (deleting the database, a self-destruct passcode, deleting the last profile), since the cases after it would start from nothing.

After the last case, run each case recorded `bug` once more, from the start of its steps: record it again, `bug` if it failed again, or `ok` with "passed on retry; first attempt: <what happened>". A case is a bug only after it failed twice.

`report.md` in your directory: one line on the app at the start, `## Findings` with each bug in detail (steps, what you saw, what you expected, screenshots) and `## Harness notes` for anything about the helpers or the runner that got in the way. Results go only to `record`; `record` alone prints what is recorded, so after the conversation has been compacted, run it to see which cases are left, and read `prompt.md` again for the rest.

The session is done when every case of the table is recorded. Your final message: the counts of ok, bug, blocked and manual, and the most important bug, then one more line: `CLAUDE-TEST: PASS` if no case is recorded bug, otherwise `CLAUDE-TEST: FAIL` and the rows recorded bug.

## Peers: the other people in a case

The `peer` helper runs CLI clients that act as contacts, group members and channel subscribers. Name each after a person (alice, bob, carol, dave, eve, …); a peer keeps its contacts, groups and messages for the whole session, so use new names when a case needs people who don't know the app yet. The app's profile is "citester": that is the name peers know it by.

- **A peer is online only while one of its commands runs.** What the app sends while it is offline reaches it at its next command. So after the app does something a peer must answer (accept a connection, join, deliver, read), run `peer <name> wait 20`, or `peer <name> messages '@citester'` to see what arrived. A group the app joins from a peer's link or invitation needs the peer, its host, online: run `peer <host> wait 30` after the app joins.
- **The app connects to a peer:** `peer alice link` (a 1-time link) or `peer alice address` prints a link; give it to the app (below), then `peer alice wait 20` so the connection completes; the app then shows the contact alice.
- **A peer connects to the app:** make a link in the app (1-time link, address, group link, channel link), get its text (below), then `peer bob connect '<link>'`; accept in the app if it asks, then `peer bob wait 20`.
- **Groups:** the app creates the group and adds peer contacts (`peer bob join '#<group>'` accepts the invitation, then `peer bob wait 20`), or a peer creates one (`peer bob group team`, `peer bob invite '#team' '@citester'`) and the app accepts.
- **Channels:** the app's channels use the preset chat relays; a peer joins one by its link (`peer bob connect '<channel link>'`) and is a subscriber. To see a channel as a subscriber in the app itself (signatures, "signature missing", the subscriber's views), add a second profile in the app and join the channel from it by the same link.
- **Messages from peers:** `peer bob send '@citester' 'hello'`; several arguments make a multi-line message; `image`, `file`, `text-file` and `voice` send attachments; `reply`, `react`, `edit`, `delete` act on messages by their text.
- Quote every argument that starts with # or @ or contains spaces or punctuation: `peer bob send '#team' 'hi (all)'`.

## Cases

| Row | Section | Case |
|---|---|---|
| 484 | groups | report another member's message, admin receives report, other members don't receive it |
| 561 | incognito mode & contact aliases | paste link to connect - incognito/not |
| 562 | incognito mode & contact aliases | create invitation link - incognito/not |
| 563 | incognito mode & contact aliases | connect via group link via paste/scan - incognito/not |
| 564 | incognito mode & contact aliases | connect via external link - incognito/not |
| 631 | member screening | group member sees flag in chat list if support chat has unread messages, number of unread support chat messages in chat view; can open support chat via bar |
| 633 | member screening | new messages in support chats increase counter for moderators (add flag in chat list if it's the only unanswered chat) |
| 634 | member screening | if another moderator answers in support chat counter is decreased for other moderators (flag is removed if it was the only unanswered chat) |
| 658 | connection plan | paste known group link into chat list search, group chat is filtered, can be opened |
| 241 | settings | advanced network settings - change, save, revert, reset, should reconnect |
| 242 | settings | advanced network settings - set proxy timeouts (ios) / enable proxy (android, resets to different values) |
| 243 | settings | protect screen setting - preference on/off, hides sheets/subviews |
| 362 | files | tap file while it is being received - opens when received |
| 700 | supporter badges | Support SimpleX opens from chat list banner and from settings; "How badges protect your privacy" opens |
| 701 | supporter badges | chat list banner - close button appears only after banner was opened |
| 703 | supporter badges | redeem wrong code / already used code - clear error, not generic failure |
| 149 | editing and deletion | delete live message while live on recipient side - created as new |
| 150 | editing and deletion | quote live message while live on recipient side - quoted with updated content |
| 153 | editing and deletion | send disappearing message - deleted for both after ttl (on recipient side after read) |
| 166 | editing and deletion | chat item info view - original (quoted) message |
| 167 | editing and deletion | chat item info view - show file servers used to deliver a file |
| 177 | chat view | group - member connected items in a row are aggregated to a single item, with updating members list |
| 198 | user contact address | accept request from new chat sheet |
| 204 | user contact address | "contact already exists" alert when connecting via contact request |
| 209 | user contact address | shared address is visible in contact info, group member info (since 5.5 - only if member has associated contact) |
| 256 | subscriptions summary indicator | data updates in real time (e.g. on start), can open server for detailed statistics, can toggle current user/all users |
| 297 | operators, conditions & smp/xftp servers advanced configuration | operators are enabled/disabled for all user profiles at once:<br>configure a custom enabled server for each protocol for current user, then disable all operators / role in a single enabled operator with that role - should show validation error for other user and prohibit save |
| 307 | chat relays configuration | enabled chat relays are chosen during channel creation (e.g. disable preset relays) |
| 312 | markdown | SimpleX links - different display/interaction mode in settings |
| 313 | markdown | SimpleX links - link with untrusted domain is colored red (in browser mode for the links) |
| 360 | files | media previews - can be viewed and interacted from chat list preview (image, video, file, voice message) |
| 399 | voice messages | voice message chat item text in quotes, compose context previews, chat previews, notifications |
| 407 | voice messages | send voice message to group - received, can be played by all members |
| 408 | voice messages | voice messages not allowed based on preference |
| 410 | voice messages | disabled voice message button shows alert how to allow - if user disabled; contact disabled; group owner |
| 412 | voice messages | group prohibits VMsg mid recording or after recording before send - rec/play stopped, preview removed |
| 414 | user / contact / group preferences | user preferences - change / reset / save, contacts updated |
| 416 | user / contact / group preferences | group preferences - change / reset / save, group members updated |
| 417 | user / contact / group preferences | updating user preferences doesn't update incognito contacts |
| 421 | user / contact / group preferences | enable preference via offer item |
| 424 | user / contact / group preferences | files not allowed based on group preference |
| 441 | groups | create group (can set picture, can add members or skip) |
| 443 | groups | add member(s) - sent and received group invitations are created, have group image |
| 444 | groups | group invitation can be accepted on chat and on chat item (on chat it can also be deleted) |
| 448 | groups | add members permissions: owners - in all roles, admins - below owner, members - not allowed |
| 450 | groups | remove member permissions: owners - allowed, admin - in role below owner, member - not allowed |
| 453 | groups | can't remove not current member (who left or was removed) |
| 454 | groups | edit group profile (display, full names, image) - group is updated, update is received by members |
| 455 | groups | inactive group indicator if user left, was removed or group was deleted |
| 458 | groups | open direct chat that is in list view, out of list view, not in chat list (new in model - network status connected) |
| 459 | groups | contacts with group members (other than host/invitee) are not created (since 5.3-beta.8) |
| 427 | db export / import | database view - export db, import db |
| 429 | db export / import | chat archive view - save archive, delete archive |
| 674 | user profiles | delete last profile |
