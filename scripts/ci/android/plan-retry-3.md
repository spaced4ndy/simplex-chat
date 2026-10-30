## Cases

| Row | Section | Case |
|---|---|---|
| 335 | files | images sent from mobile are below 236700 bytes |
| 337 | files | files are sent and received encrypted (lock icon) both in direct and group chats (since 5.3-beta.8) (since 7.0 icon is not shown by default) |
| 338 | files | send file to direct chat - statuses change on both sides during transfer, check after reopen |
| 339 | files | send file to group - file is received on accept |
| 340 | files | send file asynchronously, when file is in status accepted clicking on file shows explaining alert |
| 341 | files | cancel sending file |
| 342 | files | cancel receiving file (SMP - sender should see cancellation) |
| 343 | files | cancel receiving file, repeat receive |
| 344 | files | receive file cancellation |
| 345 | files | cancel (revoke) uploaded file |
| 346 | files | file with spaces can be sent and received |
| 347 | files | file can be saved on click |
| 348 | files | file can be saved via context menu (ios since v4.3) |
| 349 | files | send file with the same name, receive file with the same name |
| 350 | files | sent file is deleted after transfer is complete |
| 351 | files | delete chat item with file - file has to be deleted from device's app folder |
| 356 | files | link preview is not added if image/file is added; link preview is removed when image/file is added |
| 359 | files | scroll between images inside chat |
| 360 | files | media previews - can be viewed and interacted from chat list preview (image, video, file, voice message) |
| 361 | files | media (e.g. images, videos) is sent with original name replaced |
| 367 | files IP protection | configure different XFTP servers on sending and receiving devices, send file - shouldn't auto-accept (e.g. image) / should alert about unknown servers on manually accepting (any type of file) |
| 373 | voice messages | scroll voice message (since 5.1) |
| 376 | voice messages | if microphone permission is later denied alert on trying to record |
| 387 | voice messages | voice message recording is unavailable when editing |
| 391 | voice messages | exiting to chat list stops voice message chat item playback |
| 394 | voice messages | voice message chat items can be played (both sent and received) |
| 396 | voice messages | voice message recording can be saved as file via chat item context menu |
| 397 | voice messages | voice message chat items can't be edited |
| 398 | voice messages | quote voice message with other message, quote other message with voice message; displaying of quotes |
| 399 | voice messages | voice message chat item text in quotes, compose context previews, chat previews, notifications |
| 400 | voice messages | voice message can be deleted, this removes recording; can be deleted during playback |
| 401 | voice messages | playing voice message stops playback of currently playing voice message |
| 407 | voice messages | send voice message to group - received, can be played by all members |
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
| 442 | groups | groups with duplicate display names can be created |
| 516 | channels | subscriber who joins after signing is turned on sees "signature missing" on earlier messages, tap shows alert |
