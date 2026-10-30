## Cases

| Row | Section | Case |
|---|---|---|
| 209 | user contact address | shared address is visible in contact info, group member info (since 5.5 - only if member has associated contact) |
| 210 | user contact address | create 1-time link via address view - if other client scans view is dismissed; if view is closed without changes (via back or dismissing sheet on ios / clicking middle pane on desktop), delete unused invitation alert is shown |
| 221 | settings | contact should receive profile update (display, full name, both) |
| 222 | settings | set long description in profile update (Add description, contacts updated) |
| 223 | settings | test connection with a custom server (use smp6) |
| 224 | settings | set multiple custom servers (more than one) |
| 225 | settings | test server configuration change to custom (save, reopen) |
| 226 | settings | test server configuration change from custom (alert, save, reopen) |
| 227 | settings | make command via chat console (e.g. `/v`) |
| 228 | settings | webrtc server view works |
| 229 | settings | add avatar from gallery - contacts should be updated |
| 231 | settings | remove avatar - contacts should be updated |
| 233 | settings | change accent color |
| 234 | settings | change theme |
| 235 | settings | enable reachable toolbar - chat list reversed (ios, android, desktop), new chat sheet (android) |
| 237 | settings | change message roundness, tail |
| 238 | settings | enable/disable developer tools (enables "for console" sections in chat info views) |
| 239 | settings | developers tools enables additional fields in item info |
| 240 | settings | network - type of network connection is correctly shown (e.g. wifi, cellular) |
| 241 | settings | advanced network settings - change, save, revert, reset, should reconnect |
| 242 | settings | advanced network settings - set proxy timeouts (ios) / enable proxy (android, resets to different values) |
| 244 | settings | export custom theme, import theme |
| 245 | settings | set global chat theme; override with conversation chat theme |
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
