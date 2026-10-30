## Cases

| Row | Section | Case |
|---|---|---|
| 62 | short links data | in chats opened via short links with attached data feature and encryption items are created before connection (for tests below) |
| 71 | short links data | scanning business chat link shows open chat alert, open, connect, send messages |
| 95 | post-quantum encryption | connect with PQ toggle enabled on both sides (conversation should use PQ) |
| 96 | post-quantum encryption | allow PQ encryption for contact without PQ via chat info on both sides - should upgrade after a few messages |
| 97 | post-quantum encryption | test compression - send messages close to ~15 KB limit (maxEncodedMsgLength - accounting for metadata):<br>profile update with image, large 15 KB text message - both in conversations with and without PQ |
| 99 | delivery receipts | enable / disable contact receipts on profile level |
| 100 | delivery receipts | enable / disable group receipts on profile level |
| 102 | delivery receipts | enable / disable on group level (only affects one group) |
| 103 | delivery receipts | keep contact overrides when changing on profile level |
| 104 | delivery receipts | don't keep contact overrides when changing on profile level |
| 105 | delivery receipts | keep group overrides when changing on profile level |
| 106 | delivery receipts | don't keep group overrides when changing on profile level |
| 113 | sending message replies, reactions | reply in group chat to member's message, check on 3rd user's, check after reopen on all 3 |
| 114 | sending message replies, reactions | reply in group chat to user's message, check on 3rd user's, check after reopen on all 3 |
| 117 | sending message replies, reactions | add / remove message reaction - to own message / to other's message |
| 118 | sending message replies, reactions | react with same reaction (by tapping on other's reaction) |
| 169 | link previews | generate link preview, send and receive, check after reopen |
| 171 | link previews | editing link preview updates link preview on recipient's side accordingly (changes/removes it) |
| 172 | link previews | cancel link preview |
| 173 | link previews | link preview spinner |
| 184 | chat view | in 6.2 - only android/desktop: navigate via quote to message that is not loaded (e.g. quoted message is higher than last 100+ messages and chat is opened on last message after all read) |
| 187 | chat view | select text in message (Desktop) |
| 227 | settings | make command via chat console (e.g. `/v`) |
| 237 | settings | change message roundness, tail |
| 248 | settings | privacy - show last messages - hides message previews in chat list, persisted on restart |
| 249 | settings | privacy - message draft - draft is not saved when disabled |
| 250 | settings | privacy - message draft - current draft is removed when disabled |
| 251 | settings | privacy - current message draft is shown even if show last messages is disabled |
| 257 | subscriptions summary indicator | reconnect all servers, reconnect single server |
| 258 | subscriptions summary indicator | share statistics (can copy json) |
| 259 | subscriptions summary indicator | reset all statistics |
| 262 | authentication | lock - authentication can be retried if failed |
| 263 | authentication | lock - if authentication is failed when turning on/off, toggle is reset |
