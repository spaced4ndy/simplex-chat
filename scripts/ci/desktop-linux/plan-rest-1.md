## Cases

| Row | Section | Case |
|---|---|---|
| 8 | create profile -> welcome page, onboarding | logo color changes in dark mode |
| 9 | create profile -> welcome page, onboarding | create profile |
| 10 | create profile -> welcome page, onboarding | create profile, use name with spaces |
| 11 | create profile -> welcome page, onboarding | use invalid characters in profile name (e.g. "@", "@name"), correct via button |
| 12 | create profile -> welcome page, onboarding | check that empty profile and with spaces cannot be submitted |
| 13 | create profile -> welcome page, onboarding | full name is allowed to have spaces |
| 14 | create profile -> welcome page, onboarding | on start help is shown in main page, buttons work |
| 16 | create profile -> welcome page, onboarding | create address[, send email, contact to connect via link in email] |
| 17 | create profile -> welcome page, onboarding | complete onboarding |
| 18 | create profile -> welcome page, onboarding | after profile is created, messages should be received without restarting the app |
| 19 | create profile -> welcome page, onboarding | each option (create link, paste link, scan, connect to devs) works - until 4.0 |
| 20 | create profile -> welcome page, onboarding | floating / popup buttons when user has no chats - both buttons work |
| 21 | create profile -> welcome page, onboarding | choose operators / review conditions (more tests in operators & servers section) |
| 23 | create profile -> welcome page, onboarding | lock - shows notice on next (ios - on 2nd) chat start, turn on (since 5.0 - can choose system / passcode) (3+ contacts) |
| 24 | create profile -> welcome page, onboarding | connect to pre-installed SimpleX contact (since v6 - in new chat sheet) |
| 25 | create profile -> welcome page, onboarding | reachable toolbar card can be toggled, dismissed |
| 26 | create profile -> welcome page, onboarding | "create address" card - create address / open "how to use it"; create address from "how to use it" / create 1-time link (delete address and reset hints in developer tools to test different scenarios) |
| 28 | add / accept contact, send messages | initiate by creating qr code / link in current profile |
| 29 | add / accept contact, send messages | create new link, go back to new chat sheet - dialogue to delete unused link |
| 31 | add / accept contact, send messages | desktop: create new link, close by tapping in center modal - dialogue to delete unused link |
| 35 | add / accept contact, send messages | join by pasting link |
| 36 | add / accept contact, send messages | join by pasting link in search bar in chat list (only link; link with text) |
| 37 | add / accept contact, send messages | join by pasting link in search bar in new chat sheet |
| 39 | add / accept contact, send messages | join link with the initiator offline, then restart |
| 40 | add / accept contact, send messages | send/receive messages |
| 41 | add / accept contact, send messages | mark messages as read by opening conversation |
| 42 | add / accept contact, send messages | mark messages read via swipe (ios) / long press (android) |
| 43 | add / accept contact, send messages | delete contact via contact settings |
| 44 | add / accept contact, send messages | delete contact via swipe (ios) / long press (andoid) |
| 45 | add / accept contact, send messages | delete contact via new chat sheet |
| 46 | add / accept contact, send messages | delete and notify contact |
| 47 | add / accept contact, send messages | get notified about contact deletion |
| 48 | add / accept contact, send messages | delete only conversation - can be opened from new chat sheet -> Archived contacts, stays in list for session |
| 49 | add / accept contact, send messages | delete contact while keeping conversation - can be viewed in chat list |
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
