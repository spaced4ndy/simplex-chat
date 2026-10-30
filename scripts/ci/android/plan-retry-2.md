## Cases

| Row | Section | Case |
|---|---|---|
| 333 | files | image can be opened |
| 340 | files | send file asynchronously, when file is in status accepted clicking on file shows explaining alert |
| 341 | files | cancel sending file |
| 342 | files | cancel receiving file (SMP - sender should see cancellation) |
| 344 | files | receive file cancellation |
| 356 | files | link preview is not added if image/file is added; link preview is removed when image/file is added |
| 359 | files | scroll between images inside chat |
| 376 | voice messages | if microphone permission is later denied alert on trying to record |
| 409 | voice messages | contact changing preference to no disables button while in chat; can be allowed via alert; this enables button |
| 411 | voice messages | contact prohibits VMsg mid recording or after recording before send - rec/play stopped, preview removed |
| 417 | user / contact / group preferences | updating user preferences doesn't update incognito contacts |
| 421 | user / contact / group preferences | enable preference via offer item |
| 422 | user / contact / group preferences | calls not allowed based on preference |
| 426 | db export / import | stop/start chat - settings and chats are disabled when stopped |
| 429 | db export / import | chat archive view - save archive, delete archive |
| 461 | groups | open contact via "connected directly" chat item |
| 463 | groups | member deletes contact with you, sends direct message - contact is kept with security code changed |
| 470 | groups | group member aborts connection switch |
| 480 | groups | blocked member profile picture is blurred |
| 484 | groups | report another member's message, admin receives report, other members don't receive it |
| 485 | groups | send report with different reasons; with comment |
| 486 | groups | as admin moderate reported message, report is archived |
| 487 | groups | archive report without moderating (for self, for all) |
| 506 | channels | owner adds relay(s) to group, see invitation progress; subscribers connect (relay bar appears during connection) |
| 507 | channels | owner removes all relays from group, can't send messages, subscribers see warning; owner adds relay - subscribers connect to it when opening channel, see progress; messages can be sent |
| 541 | message forwarding | multi select - forward multiple message with disappearance interval (configured on conversation level; configured for current send via send button long press), messages should disappear on both sides |
| 553 | fix connection on decryption error | force renegotiate encryption with contact (dev tools), shows alert |
| 554 | fix connection on decryption error | force renegotiate encryption with group member (dev tools), shows alert |
| 558 | incognito mode & contact aliases | incognito mode persisted across sessions (turn on, reopen, turn off, reopen) |
| 559 | incognito mode & contact aliases | incognito icon is shown in incognito conversations |
| 561 | incognito mode & contact aliases | paste link to connect - incognito/not |
| 562 | incognito mode & contact aliases | create invitation link - incognito/not |
| 563 | incognito mode & contact aliases | connect via group link via paste/scan - incognito/not |
| 564 | incognito mode & contact aliases | connect via external link - incognito/not |
