## Cases

| Row | Section | Case |
|---|---|---|
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
