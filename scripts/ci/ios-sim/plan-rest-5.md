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
| 468 | groups | group member switches to a different server, send/receive message |
| 469 | groups | abort connection switch with group member |
| 470 | groups | group member aborts connection switch |
| 471 | groups | group moderation - can set member to observer, observer can't send |
| 472 | groups | group moderation - can't send as observer |
| 473 | groups | set welcome message, shown to new members |
| 474 | groups | welcome message visible in group profile to all members |
| 475 | groups | block group member, messages are marked as block |
| 476 | groups | blocked messages are grouped, can be expanded |
| 477 | groups | delete blocked messages - all messages are deleted |
| 478 | groups | unblock group member, messages are created as non blocked |
| 479 | groups | block group member for all (admin has to block) - messages marked as blocked for all members except blocked |
| 480 | groups | blocked member profile picture is blurred |
| 481 | groups | unblock group member for all |
| 482 | groups | send and receive group history - text messages, files, with removed member (created as "past" member) |
| 483 | groups | user profile update is sent to members on next message in group, member applies update if has no contact |
| 484 | groups | report another member's message, admin receives report, other members don't receive it |
| 485 | groups | send report with different reasons; with comment |
| 486 | groups | as admin moderate reported message, report is archived |
| 487 | groups | archive report without moderating (for self, for all) |
| 488 | groups | mention member - selection is filtered when typing |
| 489 | groups | be mentioned by other member, chat is marked with mention in chat list, mention is blue in chat |
| 493 | channels | create channel -> relay accepting progress view -> channel link view; join channel via link; subscriber isn't allowed to send in channel |
| 494 | channels | broadcast message to several subscribers |
| 495 | channels | broadcast different types of messages - files, images, etc. |
| 496 | channels | subscriber can react to message in channel |
| 497 | channels | subscriber count is updated for owner when new subscribers join |
| 498 | channels | subscriber count is updated for subscriber on re-opening channel |
| 499 | channels | chat info view (via channel avatar) -> shows correct texts ("channel" instead of "group"), proper lists of subscribers (for owner) / owners (for subscriber) / chat relays (for both) |
| 500 | channels | "Configure relays" view works from channel creation |
| 501 | channels | one relay offline during channel creation -> after at least one relay accepts can complete channel creation; owner has relay bar with progress |
| 502 | channels | one relay offline during subscriber join -> subscriber has relay bar with progress |
| 503 | channels | relay leaves -> relay bar appears with removed relay (expand -> "removed by operator") for both owner and subscriber |
| 504 | channels | all relays leave -> relay bar has summary warning message; broadcast is disabled |
| 505 | channels | owner removes relay(s) from group, messages are delivered via remaining relays |
| 506 | channels | owner adds relay(s) to group, see invitation progress; subscribers connect (relay bar appears during connection) |
| 507 | channels | owner removes all relays from group, can't send messages, subscribers see warning; owner adds relay - subscribers connect to it when opening channel, see progress; messages can be sent |
| 508 | channels | with custom relay (use CLI): relay leaves -> owner removes and re-adds this relay -> relay rejects (new status in UI). relay operator allows re-adding group (lifts rejection via `/group allow #<name>` api) -> owner re-adds relay again -> relay connects, both owner and subscribers see progress |
| 509 | channels | owner promotes subscriber to contributor -> this subscriber can now send messages -> other subscribers receive them; owner demotes contributor back to subscriber -> subscriber can't send |
| 510 | channels | verify an owner security code (as subscriber) |
| 511 | channels | verify a subscriber security code (as owner) |
| 512 | channels | search the subscribers list |
| 518 | chat list tags | preset tags correctly filter chat list (contacts, groups, channels, notes) |
| 519 | chat list tags | create custom tags, add chats, filter |
| 520 | chat list tags | edit tag (long press) |
| 521 | chat list tags | delete tag |
| 523 | message forwarding | forward message from/to contact/group/notes |
| 524 | message forwarding | forward to a different conversation / inside the same conversation |
| 525 | message forwarding | forward with additional message - sent as quote |
| 526 | message forwarding | can search list of chats to forward to; inactive contacts, groups, other chats are not included |
| 527 | message forwarding | forward message with file / image / video / voice message |
| 528 | message forwarding | forwarded message can't be edited |
| 529 | message forwarding | save file / image / video / voice message from other conversation to notes (via forward) |
| 530 | message forwarding | single message can't be forwarded if underlying file doesn't exist (e.g. delete via database settings) |
| 531 | message forwarding | forwarded message info (via context menu), can open origin conversation |
| 532 | message forwarding | multi select - forward multiple messages |
| 533 | message forwarding | multi select - selection order doesn't affect order of forwarded messages (should be sent in same order as in chat) |
| 534 | message forwarding | multi select - if messages with non received files are selected, dialogue to confirm sending without files or to receive files is shown on forwarding; confirming should receive files |
| 535 | message forwarding | multi select - receiving multiple files (as above) from unknown servers should show dialogue asking to confirm reception from aggregated list of servers<br>(e.g. user A sent to group via xftp1, B sent via xftp2, C only has xftp3 configured - C forwards files from A and B, dialogue to confirm both xftp1 and xftp2 servers is shown) |
| 536 | message forwarding | multi select - if messages with files in progress (receiving) are selected, dialogue to confirm sending without files or to wait is shown on forwarding |
| 537 | message forwarding | multi select - if messages with missing files are selected (e.g. all files deleted via database settings, or files cancelled), dialogue to confirm sending without files is shown on forwarding |
| 538 | message forwarding | multi select - confirming to send messages without files should forward messages texts; for missing images, image previews should also be forwarded |
| 539 | message forwarding | multi select - if message without file (non image) doesn't have text, it's not forwarded |
| 540 | message forwarding | multi select - in forward list forwarding to chat is prohibited (selection is grayed out + alert), if any of messages don't satisfy chat preferences |
| 541 | message forwarding | multi select - forward multiple message with disappearance interval (configured on conversation level; configured for current send via send button long press), messages should disappear on both sides |
| 542 | message forwarding | multi select - all messages forwarded to a chat should have their delivery status updated (single/double tick, group message info via context menu - per member statuses) |
| 544 | fix connection on decryption error | fix connection with contact on decryption error via item (view comment to reproduce) |
| 545 | fix connection on decryption error | fix connection with group member on decryption error via item |
| 546 | fix connection on decryption error | fix connection with contact on decryption error via contact info |
| 547 | fix connection on decryption error | fix connection with group member on decryption error via member info |
| 548 | fix connection on decryption error | can send and receive messages after connection fix |
| 549 | fix connection on decryption error | receive decryption error in another chat - button is active (direct, group) |
| 550 | fix connection on decryption error | re-open app - button is active (direct, group) |
| 551 | fix connection on decryption error | prohibited to send in direct chat when received permanent decryption error |
| 552 | fix connection on decryption error | prohibited to switch receiving address for contact/group member |
| 553 | fix connection on decryption error | force renegotiate encryption with contact (dev tools), shows alert |
| 554 | fix connection on decryption error | force renegotiate encryption with group member (dev tools), shows alert |
| 555 | fix connection on decryption error | contact verification is reset after connection fix |
| 556 | fix connection on decryption error | group member verification is reset after connection fix |
| 558 | incognito mode & contact aliases | incognito mode persisted across sessions (turn on, reopen, turn off, reopen) |
| 559 | incognito mode & contact aliases | incognito icon is shown in incognito conversations |
| 560 | incognito mode & contact aliases | scan qr code - incognito/not |
| 561 | incognito mode & contact aliases | paste link to connect - incognito/not |
| 562 | incognito mode & contact aliases | create invitation link - incognito/not |
| 563 | incognito mode & contact aliases | connect via group link via paste/scan - incognito/not |
| 564 | incognito mode & contact aliases | connect via external link - incognito/not |
| 565 | incognito mode & contact aliases | connect via chat item with link - incognito/not |
| 566 | incognito mode & contact aliases | connect via contact address - incognito/not |
| 567 | incognito mode & contact aliases | accept contact request via swipe (ios) / long press (android) - incognito/not |
| 568 | incognito mode & contact aliases | accept contact request via click - incognito/not |
| 569 | incognito mode & contact aliases | accept contact request via notification - incognito/not |
| 570 | incognito mode & contact aliases | connect to group member via address (group member info page) - incognito/not |
