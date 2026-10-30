## Cases

| Row | Section | Case |
|---|---|---|
| 346 | files | file with spaces can be sent and received |
| 356 | files | link preview is not added if image/file is added; link preview is removed when image/file is added |
| 358 | files | multiple images/videos can be selected and sent, text is sent with the last image |
| 367 | files IP protection | configure different XFTP servers on sending and receiving devices, send file - shouldn't auto-accept (e.g. image) / should alert about unknown servers on manually accepting (any type of file) |
| 386 | voice messages | voice message recording is unavailable when text or file/image preview is present |
| 390 | voice messages | exiting to chat list preserves draft |
| 391 | voice messages | exiting to chat list stops voice message chat item playback |
| 398 | voice messages | quote voice message with other message, quote other message with voice message; displaying of quotes |
| 400 | voice messages | voice message can be deleted, this removes recording; can be deleted during playback |
| 401 | voice messages | playing voice message stops playback of currently playing voice message |
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
| 448 | groups | add members permissions: owners - in all roles, admins - below owner, members - not allowed |
| 449 | groups | delete group permissions: owners - allowed, other - only after leaving group |
| 450 | groups | remove member permissions: owners - allowed, admin - in role below owner, member - not allowed |
| 451 | groups | edit group profile permissions: only owners are allowed |
| 452 | groups | can't leave group if already left |
| 453 | groups | can't remove not current member (who left or was removed) |
| 455 | groups | inactive group indicator if user left, was removed or group was deleted |
| 475 | groups | block group member, messages are marked as block |
| 476 | groups | blocked messages are grouped, can be expanded |
| 477 | groups | delete blocked messages - all messages are deleted |
| 478 | groups | unblock group member, messages are created as non blocked |
| 479 | groups | block group member for all (admin has to block) - messages marked as blocked for all members except blocked |
| 480 | groups | blocked member profile picture is blurred |
| 481 | groups | unblock group member for all |
| 500 | channels | "Configure relays" view works from channel creation |
| 587 | incognito mode & contact aliases | chats are searchable by alias, display name, full name |
| 598 | database encryption | chat is opened w/t passphrase if it is stored in Keychain/Keystore |
| 599 | database encryption | chat requires correct passphrase if it is not stored |
| 600 | database encryption | show password buttons work on chat start and in change password view |
| 604 | database encryption | remove from Keychain/Keystore; if re-enabled saved on passhprase change or on start |
| 617 | group links | new contacts are not in list on connection and after reload, on joining side pending connection is in list |
| 619 | group links | invited via group link chat item |
| 623 | group links | deleting group but not deleting host contact still allows to re-join group via same link (xcontactid is deleted) |
| 625 | member screening | connect to group with captcha enabled (some group from simplex directory), pass captcha test, connect to group |
| 627 | member screening | connect to group with member review as member, get accepted to group |
| 628 | member screening | connect to group with member review as observer, can send messages in support chat, get accepted to group |
| 629 | member screening | when connecting to group with admission, opening chat opens support chat view automatically; going back goes to chat list |
| 631 | member screening | group member sees flag in chat list if support chat has unread messages, number of unread support chat messages in chat view; can open support chat via bar |
| 633 | member screening | new messages in support chats increase counter for moderators (add flag in chat list if it's the only unanswered chat) |
| 634 | member screening | if another moderator answers in support chat counter is decreased for other moderators (flag is removed if it was the only unanswered chat) |
| 635 | member screening | existing member (not in review, just current member) can start support chat with moderators via group info view |
| 636 | member screening | moderator can start support chat with member via member view |
| 644 | business chats | as business add other team member to chat, other team member should have chat with client's avatar |
| 645 | business chats | as customer add friend to chat (requires business member giving you admin role), friend should have chat with business' avatar |
| 672 | user profiles | hidden profiles are not accounted in servers info - e.g. if you have 2 profiles, one of which is hidden, in non hidden profile statistics there shouldn't be "All users" option and numbers should match single profile |
| 676 | user profiles | switch new connection to user profile with different set of configured servers - connection should be re-created on servers configured for second profile; other user should be able to connect; receiving server should match server for selected profile |
