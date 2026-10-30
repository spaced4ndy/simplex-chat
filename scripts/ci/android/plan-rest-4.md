## Cases

| Row | Section | Case |
|---|---|---|
| 267 | authentication | different "lock after" intervals |
| 268 | authentication | change passcode |
| 270 | authentication | set self-destruct code, change, open with regular code, open with self-destruct code |
| 271 | authentication | set self-destruct code, change, open with self-destruct code when database key is not saved |
| 274 | operators, conditions & smp/xftp servers advanced configuration | on onboarding (new user): test selecting only simplex, only flux, both <br>- selecting flux should require accepting conditions<br>- selecting only simplex should allow to proceed without reviewing conditions<br>- selecting only flux should enable all roles for flux (check in network settings); connect, send messages |
| 276 | operators, conditions & smp/xftp servers advanced configuration | open what's new view from settings menu - opening operators selection lets update it |
| 277 | operators, conditions & smp/xftp servers advanced configuration | view / accept conditions via network settings (to test accept - update from previous version) |
| 278 | operators, conditions & smp/xftp servers advanced configuration | with simplex enabled, enable flux operator - toggle should open conditions view and require accepting conditions; dismissing should revert toggle |
| 279 | operators, conditions & smp/xftp servers advanced configuration | operator links work (Network Operator details page) |
| 280 | operators, conditions & smp/xftp servers advanced configuration | enable/disable operator, operator roles, servers; should show operator as edited in list and offer save |
| 281 | operators, conditions & smp/xftp servers advanced configuration | test operator servers - smp and xftp servers are tested in one go |
| 282 | operators, conditions & smp/xftp servers advanced configuration | via your servers, add custom server with operator domain manually / via qr code (use smp7, see simplexmq repo) - should add server to operator page to separate section under smp/xftp servers |
| 283 | operators, conditions & smp/xftp servers advanced configuration | add custom server with domain different from operators manually / via qr code (for example, use smp7 with edited domain or one community run server from https://simplex-directory.asriyan.me/) - should add server to your servers page |
| 284 | operators, conditions & smp/xftp servers advanced configuration | qr code not shown for preset servers or if server can't be parsed |
| 285 | operators, conditions & smp/xftp servers advanced configuration | test server - persisted to list of servers |
| 286 | operators, conditions & smp/xftp servers advanced configuration | test all servers - test results are displayed one by one |
| 287 | operators, conditions & smp/xftp servers advanced configuration | test server with wrong uri - test fails |
| 288 | operators, conditions & smp/xftp servers advanced configuration | delete server |
| 289 | operators, conditions & smp/xftp servers advanced configuration | preset operator servers can't be deleted; added operator servers and your servers can be deleted |
| 290 | operators, conditions & smp/xftp servers advanced configuration | delete newly added server that wasn't yet saved |
| 291 | operators, conditions & smp/xftp servers advanced configuration | delete server that was previously saved, save changes |
| 292 | operators, conditions & smp/xftp servers advanced configuration | disable server; only non disabled servers are used for new connections |
| 293 | operators, conditions & smp/xftp servers advanced configuration | save servers / reset servers / reloading chat preserves state |
| 294 | operators, conditions & smp/xftp servers advanced configuration | going back from network settings should offer to save unsaved server settings (if valid) |
| 295 | operators, conditions & smp/xftp servers advanced configuration | dismissing network settings or any operators/servers child view should offer to save unsaved server settings (if valid)<br>on ios: swipe sheet down; on desktop: click in middle pane |
| 296 | operators, conditions & smp/xftp servers advanced configuration | test operators and servers validation:<br>- invalid configuration should prohibit to save servers (missing any servers / for protocol / for roles)<br>- configuration is validated on every relevant change: disable operator / disable role / disable all servers for protocol / delete last enabled custom server - putting configuration into invalid state should be immediately shown to user<br>- same for fixing configuration: enable operator / role / enable any server for protocol / add enabled server - should immediately show validation errors are fixed<br>- validation errors are displayed in each relevant section where it can be fixed (on operator toggle, roles toggles, operator servers, your servers, save button)<br>- duplicate hostnames in server lists are shown as error on server record |
| 297 | operators, conditions & smp/xftp servers advanced configuration | operators are enabled/disabled for all user profiles at once:<br>configure a custom enabled server for each protocol for current user, then disable all operators / role in a single enabled operator with that role - should show validation error for other user and prohibit save |
| 298 | operators, conditions & smp/xftp servers advanced configuration | preset servers can be restored if any is absent |
| 299 | operators, conditions & smp/xftp servers advanced configuration | duplicate servers - error |
| 300 | operators, conditions & smp/xftp servers advanced configuration | save preset server address as custom (what should happen?) |
| 302 | operators, conditions & smp/xftp servers advanced configuration | enable/disable functions of custom servers: message reception, private routing, and name resolution |
| 304 | chat relays configuration | ^^^ similar considerations as above apply: adding, deleting, editing, validation, testing, etc. |
| 305 | chat relays configuration | add custom chat relay, trying to save with invalid name/link correctly shows error |
| 306 | chat relays configuration | test custom chat relay -> populates name, editing name becomes disabled |
| 307 | chat relays configuration | enabled chat relays are chosen during channel creation (e.g. disable preset relays) |
| 309 | markdown | markdown text selectable (can be copied), links are clickable |
| 310 | markdown | messages with link have dropdown menu |
| 311 | markdown | SimpleX links - can be interacted with w/t leading to browser |
| 312 | markdown | SimpleX links - different display/interaction mode in settings |
| 313 | markdown | SimpleX links - link with untrusted domain is colored red (in browser mode for the links) |
| 314 | markdown | SimpleX links - full link is copied |
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
