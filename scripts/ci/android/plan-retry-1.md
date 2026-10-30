## Cases

| Row | Section | Case |
|---|---|---|
| 25 | create profile -> welcome page, onboarding | reachable toolbar card can be toggled, dismissed |
| 26 | create profile -> welcome page, onboarding | "create address" card - create address / open "how to use it"; create address from "how to use it" / create 1-time link (delete address and reset hints in developer tools to test different scenarios) |
| 35 | add / accept contact, send messages | join by pasting link |
| 96 | post-quantum encryption | allow PQ encryption for contact without PQ via chat info on both sides - should upgrade after a few messages |
| 115 | sending message replies, reactions | reply to emoji (quote font is small), reply with emoji (large font) |
| 122 | private notes | create file / image / video, view, save |
| 138 | editing and deletion | irreversibly delete for recipient (preference) |
| 152 | editing and deletion | start live message with attachment added (e.g. image) - by long-pressing send button |
| 159 | editing and deletion | send live disappearing message, disappearance scheduled after live message is finished |
| 163 | editing and deletion | set custom disappearing message time - for contact, for group |
| 184 | chat view | in 6.2 - only android/desktop: navigate via quote to message that is not loaded (e.g. quoted message is higher than last 100+ messages and chat is opened on last message after all read) |
| 223 | settings | test connection with a custom server (use smp6) |
| 238 | settings | enable/disable developer tools (enables "for console" sections in chat info views) |
| 239 | settings | developers tools enables additional fields in item info |
| 245 | settings | set global chat theme; override with conversation chat theme |
| 270 | authentication | set self-destruct code, change, open with regular code, open with self-destruct code |
| 271 | authentication | set self-destruct code, change, open with self-destruct code when database key is not saved |
| 295 | operators, conditions & smp/xftp servers advanced configuration | dismissing network settings or any operators/servers child view should offer to save unsaved server settings (if valid)<br>on ios: swipe sheet down; on desktop: click in middle pane |
| 297 | operators, conditions & smp/xftp servers advanced configuration | operators are enabled/disabled for all user profiles at once:<br>configure a custom enabled server for each protocol for current user, then disable all operators / role in a single enabled operator with that role - should show validation error for other user and prohibit save |
| 298 | operators, conditions & smp/xftp servers advanced configuration | preset servers can be restored if any is absent |
| 299 | operators, conditions & smp/xftp servers advanced configuration | duplicate servers - error |
| 302 | operators, conditions & smp/xftp servers advanced configuration | enable/disable functions of custom servers: message reception, private routing, and name resolution |
| 304 | chat relays configuration | ^^^ similar considerations as above apply: adding, deleting, editing, validation, testing, etc. |
| 306 | chat relays configuration | test custom chat relay -> populates name, editing name becomes disabled |
| 307 | chat relays configuration | enabled chat relays are chosen during channel creation (e.g. disable preset relays) |
| 314 | markdown | SimpleX links - full link is copied |
| 323 | files | send image to direct chat - statuses change on both sides during transfer, check after reopen |
| 325 | files | send video, can be played inline, can be opened and played |
| 326 | files | send image via photo / from gallery |
| 327 | files | send image to group - image is received |
| 328 | files | send image asynchronously, when file is in status accepted clicking on image shows explaining alert |
| 329 | files | cancel sending image |
| 330 | files | cancel receiving image (SMP - sender should see cancellation) |
| 331 | files | receive image cancellation |
| 332 | files | image can be saved via context menu |
