# Release regression test: the SimpleX Chat Android app

You are testing the SimpleX Chat Android app, which runs in an Android emulator on this machine. Drive it only with the `ui`, `peer` and `record` helpers, through Bash, one command per call: `ui <command> [args]`. Anything else is refused; don't look for ways around that, and if something blocks a case, record it `blocked`. Their commands are listed at the end.

Your working directory is where your output goes. `ui shot <name>` saves `screens/NN-<name>.png` and prints the text on screen, one element per line after its centre `x,y` in screen pixels. Read the PNG to see the screen (1080×2400). The text comes from the app's accessibility tree, so it is spelled exactly, but it can list an element that another screen covers: when the text and the picture disagree, trust the picture. "Above" means a smaller y. `ui tree` also lists text fields and buttons that have no text.

## What is set up

- The app is already running, on its first screen, with a new, empty database: never run `ui start` or `ui stop`. Begin with `ui shot start` to see it.
- Unless the session's first case is about onboarding, onboard first. Each screen waits for the one before it; wait for a text before clicking it. Click "Get started"; click the field "Enter profile name…", type `citester`, and click "Create profile"; on "Your network", click "Continue"; the app explains instant notifications in an alert: click "Allow", and Android then asks whether the app may always run in the background: click "Allow" again; click "Accept" on the conditions screen; wait up to 60 s for the chat list, which shows "Talk to someone" while there are no conversations.
- `ui type` types into the field that has the focus: tap a field before typing into it; it types ASCII only. `ui key BACK` is Android's back button and `ui key HOME` its home button. Settings screens cover the chat list without leaving the tree: `ui relaunch` is the surest way back to the chat list.
- Besides the chats, the chat list shows the app's own cards as list items until they are closed: "New 1-time link / Paste link / Scan", "Bottom bar / Top bar", and "Invest in SimpleX Chat!".
- The emulator's Pictures folder has `test-card.jpg`, a TV test card 1280×720, and `simplex-logo.png`, the SimpleX logo on a transparent background, for cases that attach images. The emulator has no camera and no microphone.
- The app runs under ARM translation, slower than on a phone; if it dies at start, `ui relaunch` once and say so in the note.
- `ui network off` and `ui network on` switch the emulator's network (airplane mode), for cases with the network off; turn it back on afterwards.

## How to do things in the app

- **Send a message:** tap the message field, `ui type "<text>"`, then tap "Send Message".
- **A message's menu:** `ui long-press <x> <y>` on the message's text (centre from `ui find`): Reply, Edit, Delete, Info, Forward, Select, and reactions. A chat's menu in the list: long-press its row.
- **Give the app a link:** tap the search field "Search or paste SimpleX link" and `ui type '<link>'` (a long link takes a minute to type), or `ui open-link '<link>'`, which opens it as a browser would.
- **Get a link from the app:** "Share link" (or "Share 1-time link") opens Android's share sheet, whose preview shows the link's text: `ui text` or `ui tree` lists it. Or send the link as a message to a peer contact (paste it in the message field) and read it with `peer <name> messages '@citester'`.
- `ui do` runs several commands in a row and stops at the first that fails, so a failed chain tells you where it stopped: `ui do click-text "Start new chat" -- click-text "Create group" 10 -- wait "Enter group name" -- shot new-group`.

## Where things are

- **Your privacy** (Settings): at its bottom, "More privacy" holds Show last messages, Message draft, Send delivery receipts to (contacts, groups), Protect IP address and Show encryption.
- **Developer tools:** Settings, then tap the app version row, then Developer tools: Chat console, and "Show developer options", which adds more fields to item info and connection details to contact and member info.
- **Appearance** (Settings), scrolled down: App toolbars, Message shape (Corner, Tail), Profile images, font size.
- **Incognito:** on the 1-time link, address and connect screens, the profile row ("Select chat profile") lets you choose Incognito.
- **Giving the app a link reliably:** typing a link into the search field makes the app try it before it is complete. Instead have a peer contact send the link as a message (`peer bob send '@citester' '<link>'`), or put it in a Private notes message, and tap the link in the chat.
- **A peer joins a group or channel by its link** with `peer <name> connect '<link>'`; `peer <name> join` only accepts an invitation.
- **Business chats:** `peer bob address`, then `peer bob cli '/_address_settings 1 {"businessAddress":true,"autoAccept":{"acceptIncognito":false}}'`, and connect the app to bob's address; the app's own business address is a switch in its address settings, and a peer connects to it.
- **A peer's preferences for the app:** `peer bob cli '/set voice @citester no'` (always, yes or no; also files, calls, delete, disappear).
- **A long chat history:** `peer bob many '@citester' 120`.

## The regression cases

The cases of this session (the table at the end) come from the team's release regression table: each is one line written for a person who knows the app, not a list of steps. For each case, work out the shortest way to check what it says in this app, do it, check it, and record the result at once.

No one answers questions during this session: never stop to ask, and never end it before every case of the table is recorded. Each `record` prints the next case; whenever you are unsure which cases are left or what they say, for example after the conversation was compacted, run `record` alone: it lists the cases left, with their text.

1. Read the case. Where it names a gesture of another platform ("swipe (ios) / long press (android)"), use this app's own way to do the same. A case about a version upgrade, a camera, a microphone, a call, push notifications, a second device, a purchase or a badge code is `manual`: record what it needs. Where only a part of a case needs such a thing, check the rest, and say in the note which part was not checked.
2. Set up what the case needs: contacts, groups and channel subscribers are CLI peers (below); messages, settings and profiles you make in the app.
3. Do it, and check each thing the case says. Take `ui shot <row>-<what>` at the moment that shows the result (the name has only letters, digits, - and _).
4. Record it: `record <row> <ok|bug|blocked|manual> "<what you saw, in one line>" <screenshot name>`.
   - ok: everything the case says held, as you saw it.
   - bug: the app did something wrong; the note says what you did, what you saw and what you expected.
   - blocked: this runner or a helper stopped the case (say what: the peer couldn't connect, the screen couldn't be read, the app crashed at start).
   - manual: the case needs something no runner has; say what.
5. Spend at most about 20 turns on one case: when it is stuck, record it `blocked` with what stopped it, and go on.

Run the cases in the table's order, but leave to the end any case that wipes the app (deleting the database, a self-destruct passcode, deleting the last profile), since the cases after it would start from nothing.

After the last case, run each case recorded `bug` once more, from the start of its steps: record it again, `bug` if it failed again, or `ok` with "passed on retry; first attempt: <what happened>". A case is a bug only after it failed twice.

`report.md` in your directory: one line on the app at the start, `## Findings` with each bug in detail (steps, what you saw, what you expected, screenshots) and `## Harness notes` for anything about the helpers or the runner that got in the way. Results go only to `record`; `record` alone prints what is recorded, so after the conversation has been compacted, run it to see which cases are left, and read `prompt.md` again for the rest.

The session is done when every case of the table is recorded. Your final message: the counts of ok, bug, blocked and manual, and the most important bug, then one more line: `CLAUDE-TEST: PASS` if no case is recorded bug, otherwise `CLAUDE-TEST: FAIL` and the rows recorded bug.

## Peers: the other people in a case

The `peer` helper runs CLI clients that act as contacts, group members and channel subscribers. Name each after a person (alice, bob, carol, dave, eve, …); a peer keeps its contacts, groups and messages for the whole session, so use new names when a case needs people who don't know the app yet. The app's profile is "citester": that is the name peers know it by.

- **A peer is online only while one of its commands runs.** What the app sends while it is offline reaches it at its next command. So after the app does something a peer must answer (accept a connection, join, deliver, read), run `peer <name> wait 20`, or `peer <name> messages '@citester'` to see what arrived. A group the app joins from a peer's link or invitation needs the peer, its host, online: run `peer <host> wait 30` after the app joins.
- **The app connects to a peer:** `peer alice link` (a 1-time link) or `peer alice address` prints a link; give it to the app (below), then `peer alice wait 20` so the connection completes; the app then shows the contact alice.
- **A peer connects to the app:** make a link in the app (1-time link, address, group link, channel link), get its text (below), then `peer bob connect '<link>'`; accept in the app if it asks, then `peer bob wait 20`.
- **Groups:** the app creates the group and adds peer contacts (`peer bob join '#<group>'` accepts the invitation, then `peer bob wait 20`), or a peer creates one (`peer bob group team`, `peer bob invite '#team' '@citester'`) and the app accepts.
- **Channels:** the app's channels use the preset chat relays; a peer joins one by its link (`peer bob connect '<channel link>'`) and is a subscriber. To see a channel as a subscriber in the app itself (signatures, "signature missing", the subscriber's views), add a second profile in the app and join the channel from it by the same link.
- **Messages from peers:** `peer bob send '@citester' 'hello'`; several arguments make a multi-line message; `image`, `file`, `text-file` and `voice` send attachments; `reply`, `react`, `edit`, `delete` act on messages by their text.
- Quote every argument that starts with # or @ or contains spaces or punctuation: `peer bob send '#team' 'hi (all)'`.

## The ui helper
