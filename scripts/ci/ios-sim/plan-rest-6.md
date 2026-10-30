# Release regression: iOS

## On iOS, for these cases

- In this run results go to `record`, not to a Results table: skip the Results table and the `todo` rows that "The report" above describes; `report.md` holds only the line on the app at the start, `## Findings` and `## Harness notes`.
- **Give the app a link:** `ui clipboard '<link>'`, then paste it where the case says: in the search field (tap it once to focus it, once more for its menu, then "Paste"), or "Compose" → "Scan / Paste link" → "Tap to paste link" (tap "Allow Paste" if iOS asks). `ui open-link '<link>'` opens a link as another app would.
- **Get a link from the app:** its "Copy" button, or "Share link" and "Copy" in the share sheet; then `ui clipboard` prints it.
- A message's menu: `ui long-press` on the message's text; a chat's actions in the list: swipe its row (`ui swipe`) or long-press it.

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
| 571 | incognito mode & contact aliases | connect with developers (empty chat list/via help) - incognito/not |
| 572 | incognito mode & contact aliases | when creating invitation link, toggle incognito to a different value - profile is correctly chosen on connection |
| 573 | incognito mode & contact aliases | when creating invitation link, toggle incognito to a different value then back - profile is correctly chosen |
| 574 | incognito mode & contact aliases | create invitation link in incognito mode, turn it off - incognito profile should be shared |
| 575 | incognito mode & contact aliases | join via invitation link in incognito mode - incognito profile should be shared |
| 576 | incognito mode & contact aliases | turn on incognito mode after receiving contact request and accept - incognito profile should be shared |
| 577 | incognito mode & contact aliases | join via contact address in incognito mode - incognito profile should be shared |
| 578 | incognito mode & contact aliases | join via simplex address in incognito mode - incognito profile should be shared (test once) |
| 579 | incognito mode & contact aliases | group invitation texts for both incognito and main profile |
| 580 | incognito mode & contact aliases | same for accepting invitation via chat item and via click on preview - texts |
| 581 | incognito mode & contact aliases | when connected incognito to group host contact, group is joined using same incognito profile (via invite, not link) |
| 582 | incognito mode & contact aliases | prohibited to invite contacts connected incognito to group where main profile is shared + alert |
| 583 | incognito mode & contact aliases | prohibited to invite any contacts to group where incognito profile is shared + alert |
| 584 | incognito mode & contact aliases | incognito profile in replies and when quoting own messages in group |
| 585 | incognito mode & contact aliases | set contact alias - saved on press & on keyboard submit, trimmed, check after reopening |
| 586 | incognito mode & contact aliases | contact alias used across whole chat - list, chat, group, member messages, add members, member info |
| 587 | incognito mode & contact aliases | chats are searchable by alias, display name, full name |
| 588 | incognito mode & contact aliases | create group using incognito profile, group link is created; add members button replaced with group link |
| 590 | pending connections - aliases and re-open link | pending connections - set alias, converts to contact alias afterwards |
| 591 | pending connections - aliases and re-open link | invitation - can re-open link |
| 592 | pending connections - aliases and re-open link | incognito mode descriptions |
| 596 | database encryption | new installation - database is encrypted with random password |
| 597 | database encryption | new installation - requires password change to export and to remove from Keychain/Keystore |
| 598 | database encryption | chat is opened w/t passphrase if it is stored in Keychain/Keystore |
| 599 | database encryption | chat requires correct passphrase if it is not stored |
| 600 | database encryption | show password buttons work on chat start and in change password view |
| 601 | database encryption | can't update password if old password is incorrect |
| 602 | database encryption | can't update password if confirmed password doesn't match |
| 603 | database encryption | re-encrypt with new passphrase |
| 604 | database encryption | remove from Keychain/Keystore; if re-enabled saved on passhprase change or on start |
| 607 | automatic message deletion | can be turned on, first run should take no more than 1 min |
| 610 | automatic message deletion | alert is shown when ttl is decreased, can be cancelled |
| 613 | group links | create group link |
| 614 | group links | delete group link |
| 615 | group links | connect via group link [+ incognito] |
| 616 | group links | create group link when incognito in group, another client connects via this group link |
| 617 | group links | new contacts are not in list on connection and after reload, on joining side pending connection is in list |
| 618 | group links | opening chat with "group link" contact and sending message makes it stay in chat list + after reload (chat used) |
| 619 | group links | invited via group link chat item |
| 620 | group links | group link pending connection - alias can't be set |
| 621 | group links | group link is recognized + alert before confirming both on scan and paste, can be cancelled |
| 622 | group links | existing contacts are merged |
| 623 | group links | deleting group but not deleting host contact still allows to re-join group via same link (xcontactid is deleted) |
| 625 | member screening | connect to group with captcha enabled (some group from simplex directory), pass captcha test, connect to group |
| 626 | member screening | as group owner, set member admission for group to review all members; new member connects for review; owner, new member and moderator can send messages in member support chat; reject/approve member; approve member to add to group |
| 627 | member screening | connect to group with member review as member, get accepted to group |
| 628 | member screening | connect to group with member review as observer, can send messages in support chat, get accepted to group |
| 629 | member screening | when connecting to group with admission, opening chat opens support chat view automatically; going back goes to chat list |
| 630 | member screening | group moderators see flag in chat list if unanswered support chats are present, bar with number of support chats in chat view; can open support chat list via bar |
| 631 | member screening | group member sees flag in chat list if support chat has unread messages, number of unread support chat messages in chat view; can open support chat via bar |
| 632 | member screening | reading support chats / accepting, rejecting members correctly updates number of unanswered support chats / unread messages |
| 633 | member screening | new messages in support chats increase counter for moderators (add flag in chat list if it's the only unanswered chat) |
| 634 | member screening | if another moderator answers in support chat counter is decreased for other moderators (flag is removed if it was the only unanswered chat) |
| 635 | member screening | existing member (not in review, just current member) can start support chat with moderators via group info view |
| 636 | member screening | moderator can start support chat with member via member view |
| 638 | business chats | enabling business address should turn on auto-accept (toggle should be disabled), and turn off and hide incognito toggle |
| 639 | business chats | switching business address on/off should preserve welcome message |
| 640 | business chats | create business address, other client connects - conversation should have customer avatar / icon (without avatar - one person) |
| 641 | business chats | connect to other client's business address - conversation should have business avatar / icon (without avatar - briefcase) |
| 642 | business chats | relevant texts in chat info page, member info page and other views use "chat" instead of "group" |
| 643 | business chats | edit chat profile, edit welcome message (on chat info view), create group link buttons are not shown |
| 644 | business chats | as business add other team member to chat, other team member should have chat with client's avatar |
| 645 | business chats | as customer add friend to chat (requires business member giving you admin role), friend should have chat with business' avatar |
| 646 | business chats | send/receive messages/files |
| 647 | business chats | connecting to simplex chat team preset contact should create business chat (since 6.2) |
| 650 | connection plan | connect to own one-time link |
| 651 | connection plan | connect to own address |
| 652 | connection plan | connect to known address, contact chat opens |
| 653 | connection plan | paste known address into chat list search, contact chat is filtered, can be opened |
| 654 | connection plan | paste known address into new chat sheet search, contact chat is filtered, can be opened |
| 655 | connection plan | paste known address of contact with deleted conversation into new chat sheet search, contact chat is filtered, can be opened |
| 656 | connection plan | connect to own group link |
| 657 | connection plan | connect to known group link, group chat opens |
| 658 | connection plan | paste known group link into chat list search, group chat is filtered, can be opened |
| 659 | connection plan | paste known group link into new chat sheet search, group chat opens (as there are no groups in new chat sheet) |
| 660 | connection plan | connect to known business address - business chat opens |
| 661 | connection plan | paste known business address into chat list search, business chat is filtered, can be opened |
| 664 | contact verification | mark contact verified |
| 665 | contact verification | verify group member |
| 666 | contact verification | clear verification |
| 667 | contact verification | verified status shown in chat, chat list, member list |
| 669 | user profiles | create new user profile, hide it |
| 670 | user profiles | in user sheet profiles are shown in order of use |
| 671 | user profiles | notifications are not shown for hidden inactive profile |
| 672 | user profiles | hidden profiles are not accounted in servers info - e.g. if you have 2 profiles, one of which is hidden, in non hidden profile statistics there shouldn't be "All users" option and numbers should match single profile |
| 673 | user profiles | reveal hidden profile, make active, unhide, delete |
| 674 | user profiles | delete last profile |
| 675 | user profiles | switch user profile when creating connection - pending connection is created in that profile; other user should be able to connect |
| 676 | user profiles | switch new connection to user profile with different set of configured servers - connection should be re-created on servers configured for second profile; other user should be able to connect; receiving server should match server for selected profile |
| 677 | user profiles | switch new connection to different profile, then make incognito - pending connection is created incognito in that profile |
| 678 | user profiles | switch new connection between profiles and incognito in different variations - pending connection should be created in expected profile; incognito preference should be remembered for future |
| 682 | calls | call via contact info view / group member info view - if you prohibit calls, alert allows to enable them |
