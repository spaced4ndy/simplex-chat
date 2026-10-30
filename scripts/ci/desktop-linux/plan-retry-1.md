## Cases

| Row | Section | Case |
|---|---|---|
| 8 | create profile -> welcome page, onboarding | logo color changes in dark mode |
| 13 | create profile -> welcome page, onboarding | full name is allowed to have spaces |
| 23 | create profile -> welcome page, onboarding | lock - shows notice on next (ios - on 2nd) chat start, turn on (since 5.0 - can choose system / passcode) (3+ contacts) |
| 39 | add / accept contact, send messages | join link with the initiator offline, then restart |
| 50 | add / accept contact, send messages | clear conversation via contact settings |
| 51 | add / accept contact, send messages | clear conversation via swipe (ios) / long press (android) |
| 52 | add / accept contact, send messages | send message to contact that deleted you without notifying - should show error |
| 53 | add / accept contact, send messages | add contact/connect view are closed after invitation is accepted |
| 54 | add / accept contact, send messages | mark chat as unread, kept on restart |
| 56 | add / accept contact, send messages | switch contact to a different server, send/receive message |
| 57 | add / accept contact, send messages | contact switches to a different server, send/receive message |
| 58 | add / accept contact, send messages | abort connection switch with contact |
| 59 | add / accept contact, send messages | contact aborts connection switch |
| 60 | add / accept contact, send messages | mark chat as favorite, undo, filter chats |
| 62 | short links data | in chats opened via short links with attached data feature and encryption items are created before connection (for tests below) |
| 63 | short links data | scanning 1-time link shows open chat alert, open, connect, send messages |
| 66 | short links data | scanning address link shows open chat alert, open, connect with message; send messages |
| 67 | short links data | scanning address link shows open chat alert, open, connect without message; send messages |
| 69 | short links data | contact request to address creates contact on address owner side, open contact, reject; accept (another request); send messages |
| 71 | short links data | scanning business chat link shows open chat alert, open, connect, send messages |
| 73 | short links data | scanning group link shows open chat alert, open, connect, send messages |
| 78 | simplex names | connect to address via name (can use @directory.testing) |
| 79 | simplex names | connect to channel via name (can use #simplexchat.testing) |
| 80 | simplex names | try to connect to non-registered name -> shows alert that name is not registered |
| 82 | simplex names | chats can be searched by simplex name |
| 95 | post-quantum encryption | connect with PQ toggle enabled on both sides (conversation should use PQ) |
| 96 | post-quantum encryption | allow PQ encryption for contact without PQ via chat info on both sides - should upgrade after a few messages |
| 97 | post-quantum encryption | test compression - send messages close to ~15 KB limit (maxEncodedMsgLength - accounting for metadata):<br>profile update with image, large 15 KB text message - both in conversations with and without PQ |
| 99 | delivery receipts | enable / disable contact receipts on profile level |
| 100 | delivery receipts | enable / disable group receipts on profile level |
| 101 | delivery receipts | enable / disable on contact level (only affects one contact) |
| 102 | delivery receipts | enable / disable on group level (only affects one group) |
| 103 | delivery receipts | keep contact overrides when changing on profile level |
| 104 | delivery receipts | don't keep contact overrides when changing on profile level |
| 105 | delivery receipts | keep group overrides when changing on profile level |
| 106 | delivery receipts | don't keep group overrides when changing on profile level |
| 107 | delivery receipts | receive receipts from contact |
| 108 | delivery receipts | receive receipts from group member - statuses correctly displayed on message info view |
| 109 | delivery receipts | update / live message doesn't remove receipt |
| 111 | sending message replies, reactions | reply in direct chat to contact's message, check after reopening chat on both |
| 112 | sending message replies, reactions | quote in direct chat user's message, check after reopening chat on both |
| 113 | sending message replies, reactions | reply in group chat to member's message, check on 3rd user's, check after reopen on all 3 |
| 114 | sending message replies, reactions | reply in group chat to user's message, check on 3rd user's, check after reopen on all 3 |
| 115 | sending message replies, reactions | reply to emoji (quote font is small), reply with emoji (large font) |
| 116 | sending message replies, reactions | reply to markdown |
| 117 | sending message replies, reactions | add / remove message reaction - to own message / to other's message |
| 118 | sending message replies, reactions | react with same reaction (by tapping on other's reaction) |
| 142 | editing and deletion | send live message - updated on recipient side |
| 143 | editing and deletion | alert is shown before sending live message for the first time |
| 144 | editing and deletion | typing indicator is shown for sender and recipient |
| 145 | editing and deletion | live messages are not marked as edited |
| 146 | editing and deletion | edit live message after complete (should be prohibited while live / should complete live?) |
| 147 | editing and deletion | delete live message after complete (should be prohibited while live / should complete live?) |
| 148 | editing and deletion | quote live message after complete (should be prohibited while live / should complete live?) |
| 149 | editing and deletion | delete live message while live on recipient side - created as new |
| 150 | editing and deletion | quote live message while live on recipient side - quoted with updated content |
