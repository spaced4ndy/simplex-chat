## Cases

| Row | Section | Case |
|---|---|---|
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
| 570 | incognito mode & contact aliases | connect to group member via address (group member info page) - incognito/not |
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
