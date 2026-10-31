## Notes for these cases

Earlier sessions ran these cases in a way that didn't check what they say:
- 23: the notice offering SimpleX Lock shows at the next chat start only while the lock is off and the profile has 3 or more contacts: make 3 contacts, keep the lock off, and `ui relaunch`.
- 204: connect the app to a peer's address (the peer accepts), then use the same address again in the app: the "contact already exists" alert is expected.
- 619: the "invited via your group link" item is shown to the group link's owner: the app creates a group and its link, a new peer joins by it (`peer dave connect '<link>'`), and the app's group chat shows the item.

## Cases

| Row | Section | Case |
|---|---|---|
| 23 | create profile -> welcome page, onboarding | lock - shows notice on next (ios - on 2nd) chat start, turn on (since 5.0 - can choose system / passcode) (3+ contacts) |
| 204 | user contact address | "contact already exists" alert when connecting via contact request |
| 619 | group links | invited via group link chat item |
