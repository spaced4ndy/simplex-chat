# Release regression: iOS

## On iOS, for these cases

- In this run results go to `record`, not to a Results table: skip the Results table and the `todo` rows that "The report" above describes; `report.md` holds only the line on the app at the start, `## Findings` and `## Harness notes`.
- **Give the app a link:** `ui clipboard '<link>'`, then paste it where the case says: in the search field (tap it once to focus it, once more for its menu, then "Paste"), or "Compose" → "Scan / Paste link" → "Tap to paste link" (tap "Allow Paste" if iOS asks). `ui open-link '<link>'` opens a link as another app would.
- **Get a link from the app:** its "Copy" button, or "Share link" and "Copy" in the share sheet; then `ui clipboard` prints it.
- A message's menu: `ui long-press` on the message's text; a chat's actions in the list: swipe its row (`ui swipe`) or long-press it.

## The regression cases

The cases of this session (the table at the end) come from the team's release regression table: each is one line written for a person who knows the app, not a list of steps. For each case, work out the shortest way to check what it says in this app, do it, check it, and record the result at once.

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
- **Messages from peers:** `peer bob send '@citester' 'hello'`; several arguments make a multi-line message; `image`, `file`, `text-file` and `voice` send attachments; `reply`, `react`, `edit`, `delete` act on messages by their text.
- Quote every argument that starts with # or @ or contains spaces or punctuation: `peer bob send '#team' 'hi (all)'`.

## Cases

| Row | Section | Case |
|---|---|---|
| 8 | create profile -> welcome page, onboarding | logo color changes in dark mode |
| 9 | create profile -> welcome page, onboarding | create profile |
| 10 | create profile -> welcome page, onboarding | create profile, use name with spaces |
| 11 | create profile -> welcome page, onboarding | use invalid characters in profile name (e.g. "@", "@name"), correct via button |
| 12 | create profile -> welcome page, onboarding | check that empty profile and with spaces cannot be submitted |
| 13 | create profile -> welcome page, onboarding | full name is allowed to have spaces |
| 14 | create profile -> welcome page, onboarding | on start help is shown in main page, buttons work |
| 15 | create profile -> welcome page, onboarding | if app is opened via SimpleX link and profile doesn't exist, profile has to be created first |
| 16 | create profile -> welcome page, onboarding | create address[, send email, contact to connect via link in email] |
| 17 | create profile -> welcome page, onboarding | complete onboarding |
| 18 | create profile -> welcome page, onboarding | after profile is created, messages should be received without restarting the app |
| 19 | create profile -> welcome page, onboarding | each option (create link, paste link, scan, connect to devs) works - until 4.0 |
| 20 | create profile -> welcome page, onboarding | floating / popup buttons when user has no chats - both buttons work |
| 21 | create profile -> welcome page, onboarding | choose operators / review conditions (more tests in operators & servers section) |
| 22 | create profile -> welcome page, onboarding | choose notifications mode |
| 23 | create profile -> welcome page, onboarding | lock - shows notice on next (ios - on 2nd) chat start, turn on (since 5.0 - can choose system / passcode) (3+ contacts) |
| 24 | create profile -> welcome page, onboarding | connect to pre-installed SimpleX contact (since v6 - in new chat sheet) |
| 25 | create profile -> welcome page, onboarding | reachable toolbar card can be toggled, dismissed |
| 26 | create profile -> welcome page, onboarding | "create address" card - create address / open "how to use it"; create address from "how to use it" / create 1-time link (delete address and reset hints in developer tools to test different scenarios) |
| 28 | add / accept contact, send messages | initiate by creating qr code / link in current profile |
| 29 | add / accept contact, send messages | create new link, go back to new chat sheet - dialogue to delete unused link |
| 30 | add / accept contact, send messages | ios: create new link, swipe sheet down - dialogue to delete unused link |
| 33 | add / accept contact, send messages | join by clicking link / open on mobile button (outside the app starting with v.4.3) |
| 34 | add / accept contact, send messages | join via link / open on mobile button when profile is not created yet |
| 35 | add / accept contact, send messages | join by pasting link |
| 36 | add / accept contact, send messages | join by pasting link in search bar in chat list (only link; link with text) |
| 37 | add / accept contact, send messages | join by pasting link in search bar in new chat sheet |
| 39 | add / accept contact, send messages | join link with the initiator offline, then restart |
| 40 | add / accept contact, send messages | send/receive messages |
| 41 | add / accept contact, send messages | mark messages as read by opening conversation |
| 42 | add / accept contact, send messages | mark messages read via swipe (ios) / long press (android) |
| 43 | add / accept contact, send messages | delete contact via contact settings |
| 44 | add / accept contact, send messages | delete contact via swipe (ios) / long press (andoid) |
| 45 | add / accept contact, send messages | delete contact via new chat sheet |
| 46 | add / accept contact, send messages | delete and notify contact |
| 47 | add / accept contact, send messages | get notified about contact deletion |
| 48 | add / accept contact, send messages | delete only conversation - can be opened from new chat sheet -> Archived contacts, stays in list for session |
| 49 | add / accept contact, send messages | delete contact while keeping conversation - can be viewed in chat list |
| 50 | add / accept contact, send messages | clear conversation via contact settings |
| 51 | add / accept contact, send messages | clear conversation via swipe (ios) / long press (android) |
| 52 | add / accept contact, send messages | send message to contact that deleted you without notifying - should show error |
| 53 | add / accept contact, send messages | add contact/connect view are closed after invitation is accepted |
| 54 | add / accept contact, send messages | mark chat as unread, kept on restart |
| 56 | add / accept contact, send messages | switch contact to a different server, send/receive message |
| 57 | add / accept contact, send messages | contact switches to a different server, send/receive message |
| 58 | add / accept contact, send messages | abort connection switch with contact |
| 59 | add / accept contact, send messages | contact aborts connection switch |
| 60 | add / accept contact, send messages | mark chat as favorite, undo, filter chats |
| 62 | short links data | in chats opened via short links with attached data feature and encryption items are created before connection (for tests below) |
| 63 | short links data | scanning 1-time link shows open chat alert, open, connect, send messages |
| 66 | short links data | scanning address link shows open chat alert, open, connect with message; send messages |
| 67 | short links data | scanning address link shows open chat alert, open, connect without message; send messages |
| 69 | short links data | contact request to address creates contact on address owner side, open contact, reject; accept (another request); send messages |
| 71 | short links data | scanning business chat link shows open chat alert, open, connect, send messages |
| 73 | short links data | scanning group link shows open chat alert, open, connect, send messages |
| 78 | simplex names | connect to address via name (can use @directory.testing) |
| 79 | simplex names | connect to channel via name (can use #simplexchat.testing) |
| 80 | simplex names | try to connect to non-registered name -> shows alert that name is not registered |
| 82 | simplex names | chats can be searched by simplex name |
| 95 | post-quantum encryption | connect with PQ toggle enabled on both sides (conversation should use PQ) |
| 96 | post-quantum encryption | allow PQ encryption for contact without PQ via chat info on both sides - should upgrade after a few messages |
| 97 | post-quantum encryption | test compression - send messages close to ~15 KB limit (maxEncodedMsgLength - accounting for metadata):<br>profile update with image, large 15 KB text message - both in conversations with and without PQ |
| 99 | delivery receipts | enable / disable contact receipts on profile level |
| 100 | delivery receipts | enable / disable group receipts on profile level |
| 101 | delivery receipts | enable / disable on contact level (only affects one contact) |
| 102 | delivery receipts | enable / disable on group level (only affects one group) |
| 103 | delivery receipts | keep contact overrides when changing on profile level |
| 104 | delivery receipts | don't keep contact overrides when changing on profile level |
| 105 | delivery receipts | keep group overrides when changing on profile level |
| 106 | delivery receipts | don't keep group overrides when changing on profile level |
| 107 | delivery receipts | receive receipts from contact |
| 108 | delivery receipts | receive receipts from group member - statuses correctly displayed on message info view |
| 109 | delivery receipts | update / live message doesn't remove receipt |
| 111 | sending message replies, reactions | reply in direct chat to contact's message, check after reopening chat on both |
| 112 | sending message replies, reactions | quote in direct chat user's message, check after reopening chat on both |
| 113 | sending message replies, reactions | reply in group chat to member's message, check on 3rd user's, check after reopen on all 3 |
| 114 | sending message replies, reactions | reply in group chat to user's message, check on 3rd user's, check after reopen on all 3 |
| 115 | sending message replies, reactions | reply to emoji (quote font is small), reply with emoji (large font) |
| 116 | sending message replies, reactions | reply to markdown |
| 117 | sending message replies, reactions | add / remove message reaction - to own message / to other's message |
| 118 | sending message replies, reactions | react with same reaction (by tapping on other's reaction) |
| 119 | sending message replies, reactions | long press reaction in group chat to view list of reacted members, navigate to member info via this list (not yet implemented) |
| 121 | private notes | create message, edit message, delete message |
| 122 | private notes | create file / image / video, view, save |
| 123 | private notes | clear notes |
| 125 | editing and deletion | can edit today's sent message, the recipient is updated (direct/group) - shows edited icon |
| 127 | editing and deletion | can edit the message that was deleted on the recipient side, it arrives as new |
| 128 | editing and deletion | edit markdown |
| 129 | editing and deletion | edit without change - no error, no update |
| 130 | editing and deletion | can delete messages locally - mine, sender's in direct/group chats |
| 131 | editing and deletion | can delete message for all - direct/group, recipients see "deleted", can be revealed |
| 132 | editing and deletion | can delete message that was deleted by sender |
| 133 | editing and deletion | group moderation - can delete other member's message as admin |
