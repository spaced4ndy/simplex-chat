## Cases

| Row | Section | Case |
|---|---|---|
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
