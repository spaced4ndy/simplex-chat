## Cases

| Row | Section | Case |
|---|---|---|
| 266 | authentication | set passcode, requires confirmation; passcode asked on authentication |
| 267 | authentication | different "lock after" intervals |
| 268 | authentication | change passcode |
| 270 | authentication | set self-destruct code, change, open with regular code, open with self-destruct code |
| 271 | authentication | set self-destruct code, change, open with self-destruct code when database key is not saved |
| 282 | operators, conditions & smp/xftp servers advanced configuration | via your servers, add custom server with operator domain manually / via qr code (use smp7, see simplexmq repo) - should add server to operator page to separate section under smp/xftp servers |
| 283 | operators, conditions & smp/xftp servers advanced configuration | add custom server with domain different from operators manually / via qr code (for example, use smp7 with edited domain or one community run server from https://simplex-directory.asriyan.me/) - should add server to your servers page |
| 285 | operators, conditions & smp/xftp servers advanced configuration | test server - persisted to list of servers |
| 302 | operators, conditions & smp/xftp servers advanced configuration | enable/disable functions of custom servers: message reception, private routing, and name resolution |
| 306 | chat relays configuration | test custom chat relay -> populates name, editing name becomes disabled |
| 356 | files | link preview is not added if image/file is added; link preview is removed when image/file is added |
| 424 | user / contact / group preferences | files not allowed based on group preference |
| 429 | db export / import | chat archive view - save archive, delete archive |
| 448 | groups | add members permissions: owners - in all roles, admins - below owner, members - not allowed |
| 450 | groups | remove member permissions: owners - allowed, admin - in role below owner, member - not allowed |
| 476 | groups | blocked messages are grouped, can be expanded |
| 479 | groups | block group member for all (admin has to block) - messages marked as blocked for all members except blocked |
| 480 | groups | blocked member profile picture is blurred |
| 587 | incognito mode & contact aliases | chats are searchable by alias, display name, full name |
| 617 | group links | new contacts are not in list on connection and after reload, on joining side pending connection is in list |
| 619 | group links | invited via group link chat item |
| 623 | group links | deleting group but not deleting host contact still allows to re-join group via same link (xcontactid is deleted) |
| 627 | member screening | connect to group with member review as member, get accepted to group |
| 628 | member screening | connect to group with member review as observer, can send messages in support chat, get accepted to group |
| 629 | member screening | when connecting to group with admission, opening chat opens support chat view automatically; going back goes to chat list |
| 631 | member screening | group member sees flag in chat list if support chat has unread messages, number of unread support chat messages in chat view; can open support chat via bar |
| 633 | member screening | new messages in support chats increase counter for moderators (add flag in chat list if it's the only unanswered chat) |
| 634 | member screening | if another moderator answers in support chat counter is decreased for other moderators (flag is removed if it was the only unanswered chat) |
| 635 | member screening | existing member (not in review, just current member) can start support chat with moderators via group info view |
| 644 | business chats | as business add other team member to chat, other team member should have chat with client's avatar |
| 645 | business chats | as customer add friend to chat (requires business member giving you admin role), friend should have chat with business' avatar |
| 672 | user profiles | hidden profiles are not accounted in servers info - e.g. if you have 2 profiles, one of which is hidden, in non hidden profile statistics there shouldn't be "All users" option and numbers should match single profile |
| 676 | user profiles | switch new connection to user profile with different set of configured servers - connection should be re-created on servers configured for second profile; other user should be able to connect; receiving server should match server for selected profile |
