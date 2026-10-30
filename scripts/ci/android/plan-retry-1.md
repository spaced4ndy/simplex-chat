## Cases

| Row | Section | Case |
|---|---|---|
| 444 | groups | group invitation can be accepted on chat and on chat item (on chat it can also be deleted) |
| 448 | groups | add members permissions: owners - in all roles, admins - below owner, members - not allowed |
| 451 | groups | edit group profile permissions: only owners are allowed |
| 458 | groups | open direct chat that is in list view, out of list view, not in chat list (new in model - network status connected) |
| 461 | groups | open contact via "connected directly" chat item |
| 463 | groups | member deletes contact with you, sends direct message - contact is kept with security code changed |
| 469 | groups | abort connection switch with group member |
| 470 | groups | group member aborts connection switch |
| 479 | groups | block group member for all (admin has to block) - messages marked as blocked for all members except blocked |
| 480 | groups | blocked member profile picture is blurred |
| 483 | groups | user profile update is sent to members on next message in group, member applies update if has no contact |
| 484 | groups | report another member's message, admin receives report, other members don't receive it |
| 485 | groups | send report with different reasons; with comment |
| 486 | groups | as admin moderate reported message, report is archived |
| 487 | groups | archive report without moderating (for self, for all) |
| 496 | channels | subscriber can react to message in channel |
| 498 | channels | subscriber count is updated for subscriber on re-opening channel |
| 501 | channels | one relay offline during channel creation -> after at least one relay accepts can complete channel creation; owner has relay bar with progress |
| 502 | channels | one relay offline during subscriber join -> subscriber has relay bar with progress |
| 503 | channels | relay leaves -> relay bar appears with removed relay (expand -> "removed by operator") for both owner and subscriber |
| 504 | channels | all relays leave -> relay bar has summary warning message; broadcast is disabled |
| 505 | channels | owner removes relay(s) from group, messages are delivered via remaining relays |
| 506 | channels | owner adds relay(s) to group, see invitation progress; subscribers connect (relay bar appears during connection) |
| 507 | channels | owner removes all relays from group, can't send messages, subscribers see warning; owner adds relay - subscribers connect to it when opening channel, see progress; messages can be sent |
| 508 | channels | with custom relay (use CLI): relay leaves -> owner removes and re-adds this relay -> relay rejects (new status in UI). relay operator allows re-adding group (lifts rejection via `/group allow #<name>` api) -> owner re-adds relay again -> relay connects, both owner and subscribers see progress |
| 510 | channels | verify an owner security code (as subscriber) |
| 605 | database encryption | notifications are decrypted if passphrase is stored |
| 615 | group links | connect via group link [+ incognito] |
| 617 | group links | new contacts are not in list on connection and after reload, on joining side pending connection is in list |
| 618 | group links | opening chat with "group link" contact and sending message makes it stay in chat list + after reload (chat used) |
| 619 | group links | invited via group link chat item |
| 620 | group links | group link pending connection - alias can't be set |
| 625 | member screening | connect to group with captcha enabled (some group from simplex directory), pass captcha test, connect to group |
| 627 | member screening | connect to group with member review as member, get accepted to group |
| 628 | member screening | connect to group with member review as observer, can send messages in support chat, get accepted to group |
| 629 | member screening | when connecting to group with admission, opening chat opens support chat view automatically; going back goes to chat list |
| 630 | member screening | group moderators see flag in chat list if unanswered support chats are present, bar with number of support chats in chat view; can open support chat list via bar |
| 631 | member screening | group member sees flag in chat list if support chat has unread messages, number of unread support chat messages in chat view; can open support chat via bar |
| 632 | member screening | reading support chats / accepting, rejecting members correctly updates number of unanswered support chats / unread messages |
| 633 | member screening | new messages in support chats increase counter for moderators (add flag in chat list if it's the only unanswered chat) |
