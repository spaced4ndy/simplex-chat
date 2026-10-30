## Cases

| Row | Section | Case |
|---|---|---|
| 323 | files | send image to direct chat - statuses change on both sides during transfer, check after reopen |
| 324 | files | images are sent and received encrypted (lock icon) both in direct and group chats (since 5.3-beta.8) (since 7.0 icon is not shown by default) |
| 325 | files | send video, can be played inline, can be opened and played |
| 326 | files | send image via photo / from gallery |
| 327 | files | send image to group - image is received |
| 328 | files | send image asynchronously, when file is in status accepted clicking on image shows explaining alert |
| 329 | files | cancel sending image |
| 330 | files | cancel receiving image (SMP - sender should see cancellation) |
| 331 | files | receive image cancellation |
| 332 | files | image can be saved via context menu |
| 333 | files | image can be opened |
| 334 | files | delete chat item with image - file has to be deleted from device's app folder (check files number in db view) |
| 335 | files | images sent from mobile are below 236700 bytes |
| 336 | files | image over 236700 bytes shouldn't be automatically received (can be sent from terminal; don't test?) |
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
| 352 | files | file over 8 MB can't be sent; if file over 8 MB is received it should produce alert and can't be accepted (SMP) |
| 353 | files | delete contact with images and/or files - its files have to be deleted, other files have to be kept |
| 354 | files | clear contact/group with images and/or files - its files have to be deleted, other files have to be kept |
| 355 | files | image/file editing/quoting; displaying of quotes |
| 356 | files | link preview is not added if image/file is added; link preview is removed when image/file is added |
| 357 | files | delete all files from database view |
| 358 | files | multiple images/videos can be selected and sent, text is sent with the last image |
| 359 | files | scroll between images inside chat |
| 360 | files | media previews - can be viewed and interacted from chat list preview (image, video, file, voice message) |
| 361 | files | media (e.g. images, videos) is sent with original name replaced |
| 367 | files IP protection | configure different XFTP servers on sending and receiving devices, send file - shouldn't auto-accept (e.g. image) / should alert about unknown servers on manually accepting (any type of file) |
| 371 | voice messages | send/receive/listen voice message - basic, received instantly w/t acceptance |
| 372 | voice messages | voice messages are sent and received encrypted (lock icon) both in direct and group chats (since 5.3-beta.8) (since 7.0 icon is not shown by default) |
| 373 | voice messages | scroll voice message (since 5.1) |
| 374 | voice messages | if microphone permission wasn't asked before, it's asked on voice message recording |
| 375 | voice messages | voice message recording can be started after giving permission |
| 376 | voice messages | if microphone permission is later denied alert on trying to record |
| 377 | voice messages | record voice message up to limit - recording auto finished / before limit - manually finished |
| 378 | voice messages | recording with length up to limit is sent instantly (inline) |
| 379 | voice messages | record voice message via tap + stop |
| 380 | voice messages | record voice message via hold |
| 381 | voice messages | progress bar animation - percent of limit while recording, percent of recording length while playing |
| 382 | voice messages | voice message preview is disabled while recording |
| 383 | voice messages | attachment is disabled while voice message preview is present, removing preview enables attachment |
| 384 | voice messages | voice message preview - recording can be played before send |
| 385 | voice messages | voice message preview - playback can be paused and continued |
| 386 | voice messages | voice message recording is unavailable when text or file/image preview is present |
| 387 | voice messages | voice message recording is unavailable when editing |
| 388 | voice messages | preview can be removed while recording, this removes file (check via number of files in db view) |
| 389 | voice messages | preview can be removed while playing, this removes file |
| 390 | voice messages | exiting to chat list preserves draft |
| 391 | voice messages | exiting to chat list stops voice message chat item playback |
| 392 | voice messages | exiting to chat list stops voice message recording preview playback |
| 393 | voice messages | exiting to chat list stops voice message recording (microphone stops to be used) |
| 394 | voice messages | voice message chat items can be played (both sent and received) |
| 395 | voice messages | voice message progress circle animation - percent of recording |
| 396 | voice messages | voice message recording can be saved as file via chat item context menu |
| 397 | voice messages | voice message chat items can't be edited |
| 398 | voice messages | quote voice message with other message, quote other message with voice message; displaying of quotes |
| 399 | voice messages | voice message chat item text in quotes, compose context previews, chat previews, notifications |
| 400 | voice messages | voice message can be deleted, this removes recording; can be deleted during playback |
| 401 | voice messages | playing voice message stops playback of currently playing voice message |
| 402 | voice messages | playing voice message stops playback of currently playing voice message preview |
| 403 | voice messages | playing voice message preview stops playback of currently playing voice message |
| 404 | voice messages | starting voice message recording stops playback of currently playing voice message |
| 405 | voice messages | playing voice message finishes current voice message recording (in playback mode and can be sent) |
| 406 | voice messages | sending voice message stops playback of currently playing voice message preview |
| 407 | voice messages | send voice message to group - received, can be played by all members |
