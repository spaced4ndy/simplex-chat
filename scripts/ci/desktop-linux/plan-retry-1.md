## Notes for these cases

Earlier sessions ran these cases in a way that didn't check what they say:
- 23: the notice offering SimpleX Lock shows at the next chat start only while the lock is off and the profile has 3 or more contacts: make 3 contacts, keep the lock off, and `ui relaunch`.
- 183: the first unread message must be one of several: close the chat, have a peer send several separate messages (`peer bob many '@citester' 30`), then open the chat.
- 423, 449: an earlier session deleted the database before retrying them; set them up again with new peers.
- 619: the "invited via your group link" item is shown to the group link's owner: the app creates a group and its link, a new peer joins by it (`peer dave connect '<link>'`), and the app's group chat shows the item.

## Cases

| Row | Section | Case |
|---|---|---|
| 23 | create profile -> welcome page, onboarding | lock - shows notice on next (ios - on 2nd) chat start, turn on (since 5.0 - can choose system / passcode) (3+ contacts) |
| 183 | chat view | in 6.2 - only android/desktop: chat is opened on first unread message |
| 423 | user / contact / group preferences | reactions not allowed based on preference |
| 449 | groups | delete group permissions: owners - allowed, other - only after leaving group |
| 617 | group links | new contacts are not in list on connection and after reload, on joining side pending connection is in list |
| 619 | group links | invited via group link chat item |
