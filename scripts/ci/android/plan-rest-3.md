## Cases

| Row | Section | Case |
|---|---|---|
| 179 | chat view | clicking avatar opens member information |
| 181 | chat view | messages are grouped by time (time is shown on last message in group of close messages) |
| 182 | chat view | date separators and floating date are displayed when scrolling back in time |
| 183 | chat view | in 6.2 - only android/desktop: chat is opened on first unread message |
| 184 | chat view | in 6.2 - only android/desktop: navigate via quote to message that is not loaded (e.g. quoted message is higher than last 100+ messages and chat is opened on last message after all read) |
| 185 | chat view | content filter - media, links, etc. |
| 186 | chat view | navigate to message filtered via content filter |
| 193 | user contact address | create address |
| 194 | user contact address | delete address, shows alert |
| 196 | user contact address | accept request via tap in chat list - should add pending contact, then connect |
| 197 | user contact address | accept request via swipe (ios) / long press (android) |
| 198 | user contact address | accept request from new chat sheet |
| 199 | user contact address | accept request on the second attempt after error (when internet was off) |
| 200 | user contact address | accept request with the requesting client offline, then restart |
| 201 | user contact address | since v6 accepting contact request (both from chat list and new chat sheet) opens chat and allows to send messages even if contact is offline |
| 202 | user contact address | reject request - should delete contact |
| 203 | user contact address | reject request via swipe (ios) / long press (android) |
| 204 | user contact address | "contact already exists" alert when connecting via contact request |
| 205 | user contact address | auto accept, saved on reload, disable auto accept |
| 206 | user contact address | auto accept settings (text) are offered to be saved on back or dismiss (dismiss sheet on ios / click middle pane on desktop) |
| 207 | user contact address | share with contacts dialogue on creation |
| 208 | user contact address | share with contacts toggle - confirm / cancel (reverts toggle) |
| 209 | user contact address | shared address is visible in contact info, group member info (since 5.5 - only if member has associated contact) |
| 210 | user contact address | create 1-time link via address view - if other client scans view is dismissed; if view is closed without changes (via back or dismissing sheet on ios / clicking middle pane on desktop), delete unused invitation alert is shown |
| 212 | notifications | when message arrives in another chat |
| 213 | notifications | open another chat via notification, send message from the opened chat |
| 214 | notifications | when message arrives in background |
| 215 | notifications | when contact is connected |
| 216 | notifications | when contact request is received |
| 217 | notifications | accept contact request via notification |
| 218 | notifications | android chat service - can be turned on/off from settings, service keeps running when chat is closed |
| 219 | notifications | android chat service - notifications arrive with service running |
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
| 232 | settings | change app icon |
| 233 | settings | change accent color |
| 234 | settings | change theme |
| 235 | settings | enable reachable toolbar - chat list reversed (ios, android, desktop), new chat sheet (android) |
| 237 | settings | change message roundness, tail |
| 238 | settings | enable/disable developer tools (enables "for console" sections in chat info views) |
| 239 | settings | developers tools enables additional fields in item info |
| 240 | settings | network - type of network connection is correctly shown (e.g. wifi, cellular) |
| 241 | settings | advanced network settings - change, save, revert, reset, should reconnect |
| 242 | settings | advanced network settings - set proxy timeouts (ios) / enable proxy (android, resets to different values) |
| 243 | settings | protect screen setting - preference on/off, hides sheets/subviews |
| 244 | settings | export custom theme, import theme |
| 245 | settings | set global chat theme; override with conversation chat theme |
| 246 | settings | restart, shutdown app buttons - android (turns off service) |
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
