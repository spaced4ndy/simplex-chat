## Cases

| Row | Section | Case |
|---|---|---|
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
| 672 | user profiles | hidden profiles are not accounted in servers info - e.g. if you have 2 profiles, one of which is hidden, in non hidden profile statistics there shouldn't be "All users" option and numbers should match single profile |
| 673 | user profiles | reveal hidden profile, make active, unhide, delete |
| 674 | user profiles | delete last profile |
| 675 | user profiles | switch user profile when creating connection - pending connection is created in that profile; other user should be able to connect |
| 676 | user profiles | switch new connection to user profile with different set of configured servers - connection should be re-created on servers configured for second profile; other user should be able to connect; receiving server should match server for selected profile |
| 677 | user profiles | switch new connection to different profile, then make incognito - pending connection is created incognito in that profile |
| 678 | user profiles | switch new connection between profiles and incognito in different variations - pending connection should be created in expected profile; incognito preference should be remembered for future |
| 682 | calls | call via contact info view / group member info view - if you prohibit calls, alert allows to enable them |
