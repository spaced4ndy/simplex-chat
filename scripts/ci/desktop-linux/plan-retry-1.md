## Cases

| Row | Section | Case |
|---|---|---|
| 506 | channels | owner adds relay(s) to group, see invitation progress; subscribers connect (relay bar appears during connection) |
| 508 | channels | with custom relay (use CLI): relay leaves -> owner removes and re-adds this relay -> relay rejects (new status in UI). relay operator allows re-adding group (lifts rejection via `/group allow #<name>` api) -> owner re-adds relay again -> relay connects, both owner and subscribers see progress |
| 536 | message forwarding | multi select - if messages with files in progress (receiving) are selected, dialogue to confirm sending without files or to wait is shown on forwarding |
| 541 | message forwarding | multi select - forward multiple message with disappearance interval (configured on conversation level; configured for current send via send button long press), messages should disappear on both sides |
| 545 | fix connection on decryption error | fix connection with group member on decryption error via item |
| 546 | fix connection on decryption error | fix connection with contact on decryption error via contact info |
| 547 | fix connection on decryption error | fix connection with group member on decryption error via member info |
| 549 | fix connection on decryption error | receive decryption error in another chat - button is active (direct, group) |
| 550 | fix connection on decryption error | re-open app - button is active (direct, group) |
| 551 | fix connection on decryption error | prohibited to send in direct chat when received permanent decryption error |
| 552 | fix connection on decryption error | prohibited to switch receiving address for contact/group member |
| 553 | fix connection on decryption error | force renegotiate encryption with contact (dev tools), shows alert |
| 554 | fix connection on decryption error | force renegotiate encryption with group member (dev tools), shows alert |
| 555 | fix connection on decryption error | contact verification is reset after connection fix |
| 556 | fix connection on decryption error | group member verification is reset after connection fix |
| 558 | incognito mode & contact aliases | incognito mode persisted across sessions (turn on, reopen, turn off, reopen) |
| 570 | incognito mode & contact aliases | connect to group member via address (group member info page) - incognito/not |
| 571 | incognito mode & contact aliases | connect with developers (empty chat list/via help) - incognito/not |
| 576 | incognito mode & contact aliases | turn on incognito mode after receiving contact request and accept - incognito profile should be shared |
| 585 | incognito mode & contact aliases | set contact alias - saved on press & on keyboard submit, trimmed, check after reopening |
