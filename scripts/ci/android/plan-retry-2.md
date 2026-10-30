## Cases

| Row | Section | Case |
|---|---|---|
| 165 | editing and deletion | chat item info view - delivery statuses for sent group messages |
| 166 | editing and deletion | chat item info view - original (quoted) message |
| 167 | editing and deletion | chat item info view - show file servers used to deliver a file |
| 169 | link previews | generate link preview, send and receive, check after reopen |
| 170 | link previews | changing link or link's text before sending (faster than link preview updated) sends message without link preview |
| 171 | link previews | editing link preview updates link preview on recipient's side accordingly (changes/removes it) |
| 172 | link previews | cancel link preview |
| 173 | link previews | link preview spinner |
| 175 | chat view | group - member avatar is shown only once per series |
| 176 | chat view | group - member name is shown only once per series on specific items (e.g. not shown for events) |
| 177 | chat view | group - member connected items in a row are aggregated to a single item, with updating members list |
| 178 | chat view | feature items are aggregated (connect with contact) |
| 184 | chat view | in 6.2 - only android/desktop: navigate via quote to message that is not loaded (e.g. quoted message is higher than last 100+ messages and chat is opened on last message after all read) |
| 204 | user contact address | "contact already exists" alert when connecting via contact request |
| 223 | settings | test connection with a custom server (use smp6) |
| 233 | settings | change accent color |
| 234 | settings | change theme |
| 235 | settings | enable reachable toolbar - chat list reversed (ios, android, desktop), new chat sheet (android) |
| 237 | settings | change message roundness, tail |
| 238 | settings | enable/disable developer tools (enables "for console" sections in chat info views) |
| 239 | settings | developers tools enables additional fields in item info |
| 240 | settings | network - type of network connection is correctly shown (e.g. wifi, cellular) |
| 245 | settings | set global chat theme; override with conversation chat theme |
| 252 | settings | privacy - blur media |
| 270 | authentication | set self-destruct code, change, open with regular code, open with self-destruct code |
| 271 | authentication | set self-destruct code, change, open with self-destruct code when database key is not saved |
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
