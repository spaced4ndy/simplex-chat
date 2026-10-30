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
| 355 | files | image/file editing/quoting; displaying of quotes |
| 356 | files | link preview is not added if image/file is added; link preview is removed when image/file is added |
| 357 | files | delete all files from database view |
| 358 | files | multiple images/videos can be selected and sent, text is sent with the last image |
| 359 | files | scroll between images inside chat |
| 360 | files | media previews - can be viewed and interacted from chat list preview (image, video, file, voice message) |
| 361 | files | media (e.g. images, videos) is sent with original name replaced |
| 367 | files IP protection | configure different XFTP servers on sending and receiving devices, send file - shouldn't auto-accept (e.g. image) / should alert about unknown servers on manually accepting (any type of file) |
| 371 | voice messages | send/receive/listen voice message - basic, received instantly w/t acceptance |
| 372 | voice messages | voice messages are sent and received encrypted (lock icon) both in direct and group chats (since 5.3-beta.8) (since 7.0 icon is not shown by default) |
| 373 | voice messages | scroll voice message (since 5.1) |
| 374 | voice messages | if microphone permission wasn't asked before, it's asked on voice message recording |
| 375 | voice messages | voice message recording can be started after giving permission |
| 376 | voice messages | if microphone permission is later denied alert on trying to record |
| 377 | voice messages | record voice message up to limit - recording auto finished / before limit - manually finished |
| 378 | voice messages | recording with length up to limit is sent instantly (inline) |
| 379 | voice messages | record voice message via tap + stop |
| 380 | voice messages | record voice message via hold |
| 381 | voice messages | progress bar animation - percent of limit while recording, percent of recording length while playing |
| 382 | voice messages | voice message preview is disabled while recording |
| 383 | voice messages | attachment is disabled while voice message preview is present, removing preview enables attachment |
| 384 | voice messages | voice message preview - recording can be played before send |
| 385 | voice messages | voice message preview - playback can be paused and continued |
| 386 | voice messages | voice message recording is unavailable when text or file/image preview is present |
| 387 | voice messages | voice message recording is unavailable when editing |
| 388 | voice messages | preview can be removed while recording, this removes file (check via number of files in db view) |
| 389 | voice messages | preview can be removed while playing, this removes file |
| 390 | voice messages | exiting to chat list preserves draft |
| 391 | voice messages | exiting to chat list stops voice message chat item playback |
| 392 | voice messages | exiting to chat list stops voice message recording preview playback |
| 393 | voice messages | exiting to chat list stops voice message recording (microphone stops to be used) |
| 394 | voice messages | voice message chat items can be played (both sent and received) |
| 395 | voice messages | voice message progress circle animation - percent of recording |
| 396 | voice messages | voice message recording can be saved as file via chat item context menu |
| 397 | voice messages | voice message chat items can't be edited |
| 398 | voice messages | quote voice message with other message, quote other message with voice message; displaying of quotes |
| 399 | voice messages | voice message chat item text in quotes, compose context previews, chat previews, notifications |
| 400 | voice messages | voice message can be deleted, this removes recording; can be deleted during playback |
| 401 | voice messages | playing voice message stops playback of currently playing voice message |
| 402 | voice messages | playing voice message stops playback of currently playing voice message preview |
| 403 | voice messages | playing voice message preview stops playback of currently playing voice message |
| 404 | voice messages | starting voice message recording stops playback of currently playing voice message |
| 405 | voice messages | playing voice message finishes current voice message recording (in playback mode and can be sent) |
| 406 | voice messages | sending voice message stops playback of currently playing voice message preview |
| 407 | voice messages | send voice message to group - received, can be played by all members |
| 408 | voice messages | voice messages not allowed based on preference |
| 409 | voice messages | contact changing preference to no disables button while in chat; can be allowed via alert; this enables button |
| 410 | voice messages | disabled voice message button shows alert how to allow - if user disabled; contact disabled; group owner |
| 411 | voice messages | contact prohibits VMsg mid recording or after recording before send - rec/play stopped, preview removed |
| 412 | voice messages | group prohibits VMsg mid recording or after recording before send - rec/play stopped, preview removed |
| 414 | user / contact / group preferences | user preferences - change / reset / save, contacts updated |
| 415 | user / contact / group preferences | contact preferences - change / reset / save, contact updated |
| 416 | user / contact / group preferences | group preferences - change / reset / save, group members updated |
| 417 | user / contact / group preferences | updating user preferences doesn't update incognito contacts |
| 418 | user / contact / group preferences | only group owner can update preferences, group members can only view, different descriptions |
| 419 | user / contact / group preferences | feature allowed (contacts) / enabled (groups) state is correctly displayed |
| 420 | user / contact / group preferences | preferences chat items are created on connection and on change (only changed preferences) |
| 421 | user / contact / group preferences | enable preference via offer item |
| 422 | user / contact / group preferences | calls not allowed based on preference |
| 423 | user / contact / group preferences | reactions not allowed based on preference |
| 424 | user / contact / group preferences | files not allowed based on group preference |
| 426 | db export / import | stop/start chat - settings and chats are disabled when stopped |
| 427 | db export / import | database view - export db, import db |
| 428 | db export / import | database view - delete db, restart |
| 429 | db export / import | chat archive view - save archive, delete archive |
| 441 | groups | create group (can set picture, can add members or skip) |
| 442 | groups | groups with duplicate display names can be created |
| 443 | groups | add member(s) - sent and received group invitations are created, have group image |
| 444 | groups | group invitation can be accepted on chat and on chat item (on chat it can also be deleted) |
| 445 | groups | snd and rcv group events |
| 446 | groups | add members in different roles |
| 447 | groups | search members when adding |
| 448 | groups | add members permissions: owners - in all roles, admins - below owner, members - not allowed |
| 449 | groups | delete group permissions: owners - allowed, other - only after leaving group |
| 450 | groups | remove member permissions: owners - allowed, admin - in role below owner, member - not allowed |
| 451 | groups | edit group profile permissions: only owners are allowed |
| 452 | groups | can't leave group if already left |
| 453 | groups | can't remove not current member (who left or was removed) |
| 454 | groups | edit group profile (display, full names, image) - group is updated, update is received by members |
| 455 | groups | inactive group indicator if user left, was removed or group was deleted |
| 456 | groups | navigate to group member info via profile icon in chat |
| 457 | groups | open direct chat when group member info opened both from chat and from group info |
| 458 | groups | open direct chat that is in list view, out of list view, not in chat list (new in model - network status connected) |
| 459 | groups | contacts with group members (other than host/invitee) are not created (since 5.3-beta.8) |
| 460 | groups | sending direct message to member w/t contact - send / receive invitation (requires group pref "direct messages") |
| 461 | groups | open contact via "connected directly" chat item |
| 462 | groups | delete contact with group member, send direct message to group member - invitation is sent, contact is created |
| 463 | groups | member deletes contact with you, sends direct message - contact is kept with security code changed |
| 464 | groups | change member role, other members receive |
| 465 | groups | changing member role correctly changes available group actions for member |
| 466 | groups | can delete contact while it is in group(s) |
| 467 | groups | switch group member to a different server, send/receive message |
