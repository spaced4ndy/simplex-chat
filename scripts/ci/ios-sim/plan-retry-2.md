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
| 460 | groups | sending direct message to member w/t contact - send / receive invitation (requires group pref "direct messages") |
| 461 | groups | open contact via "connected directly" chat item |
| 462 | groups | delete contact with group member, send direct message to group member - invitation is sent, contact is created |
| 463 | groups | member deletes contact with you, sends direct message - contact is kept with security code changed |
| 466 | groups | can delete contact while it is in group(s) |
| 467 | groups | switch group member to a different server, send/receive message |
| 469 | groups | abort connection switch with group member |
| 483 | groups | user profile update is sent to members on next message in group, member applies update if has no contact |
| 484 | groups | report another member's message, admin receives report, other members don't receive it |
| 485 | groups | send report with different reasons; with comment |
| 486 | groups | as admin moderate reported message, report is archived |
| 487 | groups | archive report without moderating (for self, for all) |
| 489 | groups | be mentioned by other member, chat is marked with mention in chat list, mention is blue in chat |
| 490 | groups | auto-accept group invitations (Privacy & security -> Auto-accept -> Group invitations), per profile - joined automatically |
| 491 | groups | invitation to another group sent to group member (CLI) - shown as "For you only", can be accepted: CLI creates groups g1 (direct messages allowed) and g2, app user joins g1; in CLI `/i #g1 <app user>` (g1 group ID, member ID), `/i #g2` (g2 group ID), `/_add #<g2 ID> #<g1 ID> <member ID> member` - app gets invitation to g2 in g1 marked "For you only", accepts, joins g2 |
| 495 | channels | broadcast different types of messages - files, images, etc. |
| 509 | channels | owner promotes subscriber to contributor -> this subscriber can now send messages -> other subscribers receive them; owner demotes contributor back to subscriber -> subscriber can't send |
| 513 | channels | owner makes subscriber moderator - member info shows Moderator; moderator sees subscribers list |
| 514 | channels | moderator deletes message for all - deleted for all subscribers |
| 515 | channels | owner turns on Sign messages (channel preferences) - confirmation alert; new messages show signature mark, item info shows "Signed & verified" |
| 516 | channels | subscriber who joins after signing is turned on sees "signature missing" on earlier messages, tap shows alert |
| 530 | message forwarding | single message can't be forwarded if underlying file doesn't exist (e.g. delete via database settings) |
| 538 | message forwarding | multi select - confirming to send messages without files should forward messages texts; for missing images, image previews should also be forwarded |
| 542 | message forwarding | multi select - all messages forwarded to a chat should have their delivery status updated (single/double tick, group message info via context menu - per member statuses) |
| 558 | incognito mode & contact aliases | incognito mode persisted across sessions (turn on, reopen, turn off, reopen) |
| 559 | incognito mode & contact aliases | incognito icon is shown in incognito conversations |
| 561 | incognito mode & contact aliases | paste link to connect - incognito/not |
| 562 | incognito mode & contact aliases | create invitation link - incognito/not |
| 563 | incognito mode & contact aliases | connect via group link via paste/scan - incognito/not |
| 564 | incognito mode & contact aliases | connect via external link - incognito/not |
| 565 | incognito mode & contact aliases | connect via chat item with link - incognito/not |
| 566 | incognito mode & contact aliases | connect via contact address - incognito/not |
| 567 | incognito mode & contact aliases | accept contact request via swipe (ios) / long press (android) - incognito/not |
| 568 | incognito mode & contact aliases | accept contact request via click - incognito/not |
| 570 | incognito mode & contact aliases | connect to group member via address (group member info page) - incognito/not |
| 574 | incognito mode & contact aliases | create invitation link in incognito mode, turn it off - incognito profile should be shared |
| 576 | incognito mode & contact aliases | turn on incognito mode after receiving contact request and accept - incognito profile should be shared |
| 604 | database encryption | remove from Keychain/Keystore; if re-enabled saved on passhprase change or on start |
| 618 | group links | opening chat with "group link" contact and sending message makes it stay in chat list + after reload (chat used) |
| 619 | group links | invited via group link chat item |
| 620 | group links | group link pending connection - alias can't be set |
| 627 | member screening | connect to group with member review as member, get accepted to group |
| 628 | member screening | connect to group with member review as observer, can send messages in support chat, get accepted to group |
| 629 | member screening | when connecting to group with admission, opening chat opens support chat view automatically; going back goes to chat list |
| 630 | member screening | group moderators see flag in chat list if unanswered support chats are present, bar with number of support chats in chat view; can open support chat list via bar |
| 631 | member screening | group member sees flag in chat list if support chat has unread messages, number of unread support chat messages in chat view; can open support chat via bar |
| 633 | member screening | new messages in support chats increase counter for moderators (add flag in chat list if it's the only unanswered chat) |
| 634 | member screening | if another moderator answers in support chat counter is decreased for other moderators (flag is removed if it was the only unanswered chat) |
| 635 | member screening | existing member (not in review, just current member) can start support chat with moderators via group info view |
| 641 | business chats | connect to other client's business address - conversation should have business avatar / icon (without avatar - briefcase) |
| 643 | business chats | edit chat profile, edit welcome message (on chat info view), create group link buttons are not shown |
| 644 | business chats | as business add other team member to chat, other team member should have chat with client's avatar |
| 645 | business chats | as customer add friend to chat (requires business member giving you admin role), friend should have chat with business' avatar |
| 647 | business chats | connecting to simplex chat team preset contact should create business chat (since 6.2) |
| 651 | connection plan | connect to own address |
| 653 | connection plan | paste known address into chat list search, contact chat is filtered, can be opened |
| 657 | connection plan | connect to known group link, group chat opens |
| 658 | connection plan | paste known group link into chat list search, group chat is filtered, can be opened |
| 660 | connection plan | connect to known business address - business chat opens |
| 661 | connection plan | paste known business address into chat list search, business chat is filtered, can be opened |
| 670 | user profiles | in user sheet profiles are shown in order of use |
| 674 | user profiles | delete last profile |
| 700 | supporter badges | Support SimpleX opens from chat list banner and from settings; "How badges protect your privacy" opens |
| 701 | supporter badges | chat list banner - close button appears only after banner was opened |
| 703 | supporter badges | redeem wrong code / already used code - clear error, not generic failure |
| 707 | supporter badges | ios: "Choose your badge" opens badge page in browser; no in-app purchase, no Restore purchases |
