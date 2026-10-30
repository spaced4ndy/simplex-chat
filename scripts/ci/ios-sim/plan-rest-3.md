# Release regression: iOS

## On iOS, for these cases

- In this run results go to `record`, not to a Results table: skip the Results table and the `todo` rows that "The report" above describes; `report.md` holds only the line on the app at the start, `## Findings` and `## Harness notes`.
- **Give the app a link:** `ui clipboard '<link>'`, then paste it where the case says: in the search field (tap it once to focus it, once more for its menu, then "Paste"), or "Compose" → "Scan / Paste link" → "Tap to paste link" (tap "Allow Paste" if iOS asks). `ui open-link '<link>'` opens a link as another app would.
- **Get a link from the app:** its "Copy" button, or "Share link" and "Copy" in the share sheet; then `ui clipboard` prints it.
- A message's menu: `ui long-press` on the message's text; a chat's actions in the list: swipe its row (`ui swipe`) or long-press it.

## The regression cases

The cases of this session (the table at the end) come from the team's release regression table: each is one line written for a person who knows the app, not a list of steps. For each case, work out the shortest way to check what it says in this app, do it, check it, and record the result at once.

1. Read the case. Where it names a gesture of another platform ("swipe (ios) / long press (android)"), use this app's own way to do the same. A case about a version upgrade, a camera, a microphone, a call, push notifications, a second device, a purchase or a badge code is `manual`: record what it needs. Where only a part of a case needs such a thing, check the rest, and say in the note which part was not checked.
2. Set up what the case needs: contacts, groups and channel subscribers are CLI peers (below); messages, settings and profiles you make in the app.
3. Do it, and check each thing the case says. Take `ui shot <row>-<what>` at the moment that shows the result (the name has only letters, digits, - and _).
4. Record it: `record <row> <ok|bug|blocked|manual> "<what you saw, in one line>" <screenshot name>`.
   - ok: everything the case says held, as you saw it.
   - bug: the app did something wrong; the note says what you did, what you saw and what you expected.
   - blocked: this runner or a helper stopped the case (say what: the peer couldn't connect, the screen couldn't be read, the app crashed at start).
   - manual: the case needs something no runner has; say what.
5. Spend at most about 20 turns on one case: when it is stuck, record it `blocked` with what stopped it, and go on.

Run the cases in the table's order, but leave to the end any case that wipes the app (deleting the database, a self-destruct passcode, deleting the last profile), since the cases after it would start from nothing.

After the last case, run each case recorded `bug` once more, from the start of its steps: record it again, `bug` if it failed again, or `ok` with "passed on retry; first attempt: <what happened>". A case is a bug only after it failed twice.

`report.md` in your directory: one line on the app at the start, `## Findings` with each bug in detail (steps, what you saw, what you expected, screenshots) and `## Harness notes` for anything about the helpers or the runner that got in the way. Results go only to `record`; `record` alone prints what is recorded, so after the conversation has been compacted, run it to see which cases are left, and read `prompt.md` again for the rest.

The session is done when every case of the table is recorded. Your final message: the counts of ok, bug, blocked and manual, and the most important bug, then one more line: `CLAUDE-TEST: PASS` if no case is recorded bug, otherwise `CLAUDE-TEST: FAIL` and the rows recorded bug.

## Peers: the other people in a case

The `peer` helper runs CLI clients that act as contacts, group members and channel subscribers. Name each after a person (alice, bob, carol, dave, eve, …); a peer keeps its contacts, groups and messages for the whole session, so use new names when a case needs people who don't know the app yet. The app's profile is "citester": that is the name peers know it by.

- **A peer is online only while one of its commands runs.** What the app sends while it is offline reaches it at its next command. So after the app does something a peer must answer (accept a connection, join, deliver, read), run `peer <name> wait 20`, or `peer <name> messages '@citester'` to see what arrived. A group the app joins from a peer's link or invitation needs the peer, its host, online: run `peer <host> wait 30` after the app joins.
- **The app connects to a peer:** `peer alice link` (a 1-time link) or `peer alice address` prints a link; give it to the app (below), then `peer alice wait 20` so the connection completes; the app then shows the contact alice.
- **A peer connects to the app:** make a link in the app (1-time link, address, group link, channel link), get its text (below), then `peer bob connect '<link>'`; accept in the app if it asks, then `peer bob wait 20`.
- **Groups:** the app creates the group and adds peer contacts (`peer bob join '#<group>'` accepts the invitation, then `peer bob wait 20`), or a peer creates one (`peer bob group team`, `peer bob invite '#team' '@citester'`) and the app accepts.
- **Messages from peers:** `peer bob send '@citester' 'hello'`; several arguments make a multi-line message; `image`, `file`, `text-file` and `voice` send attachments; `reply`, `react`, `edit`, `delete` act on messages by their text.
- Quote every argument that starts with # or @ or contains spaces or punctuation: `peer bob send '#team' 'hi (all)'`.

## Cases

| Row | Section | Case |
|---|---|---|
| 244 | settings | export custom theme, import theme |
| 245 | settings | set global chat theme; override with conversation chat theme |
| 247 | settings | pull to reconnect - ios |
| 248 | settings | privacy - show last messages - hides message previews in chat list, persisted on restart |
| 249 | settings | privacy - message draft - draft is not saved when disabled |
| 250 | settings | privacy - message draft - current draft is removed when disabled |
| 251 | settings | privacy - current message draft is shown even if show last messages is disabled |
| 252 | settings | privacy - blur media |
| 256 | subscriptions summary indicator | data updates in real time (e.g. on start), can open server for detailed statistics, can toggle current user/all users |
| 257 | subscriptions summary indicator | reconnect all servers, reconnect single server |
| 258 | subscriptions summary indicator | share statistics (can copy json) |
| 259 | subscriptions summary indicator | reset all statistics |
| 261 | authentication | lock - authentication asked on turn on/off, start, opening from background, opening on sheet/modal |
| 262 | authentication | lock - authentication can be retried if failed |
| 263 | authentication | lock - if authentication is failed when turning on/off, toggle is reset |
| 264 | authentication | lock - if authentication is unavailable lock is turned off |
| 265 | authentication | lock notice - alert if authentication is unavailable |
| 266 | authentication | set passcode, requires confirmation; passcode asked on authentication |
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
| 301 | operators, conditions & smp/xftp servers advanced configuration | edit mode in server list - delete, change order (ios only) |
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
| 352 | files | file over 8 MB can't be sent; if file over 8 MB is received it should produce alert and can't be accepted (SMP) |
| 353 | files | delete contact with images and/or files - its files have to be deleted, other files have to be kept |
| 354 | files | clear contact/group with images and/or files - its files have to be deleted, other files have to be kept |
