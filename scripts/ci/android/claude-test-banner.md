# Test: the chat list's banner at app start after closing "Support SimpleX"

You are testing the SimpleX Chat Android app, which runs in an Android emulator on this machine. Drive it only with the `ui` helper, through Bash, one command per call: `ui <command> [args]`. Anything else is refused; don't look for ways around that, and if something blocks the test, report it. The commands are listed at the end.

Your working directory is where your output goes. `ui shot <name>` saves `screens/NN-<name>.png` and prints the text on screen, one element per line after its centre `x,y` in screen pixels. Read the PNG to see the screen (1080x2400). The text comes from the app's accessibility tree, so it is spelled exactly, but it can list an element that another screen covers: when the text and the picture disagree, trust the picture. "Above" means a smaller y. `ui tree` also lists buttons that have no text, such as "Close button".

`ui burst <name> <secs>` restarts the app and takes screenshots as fast as the emulator gives them, for secs seconds from the restart: each is `screens/NN-<name>/<ms>.png`, named by the milliseconds since the restart, and `screens/NN-<name>.png` is a contact sheet of them all in order, each labelled with its ms. It then prints the text on screen at the end.

## What is set up

- The app is already running, on its first screen, with a new, empty database: never run `ui start` or `ui stop`. Begin with `ui shot start` to see it.
- `ui type` types into the field that has the focus: tap a field before typing into it. `ui key BACK` is Android's back button.
- The chat list shows one banner at a time near its top, as a list item: "Support SimpleX" (subtitle "Get badge + better files", with a phone picture) when there are more than 3 chats, otherwise "Invest in SimpleX Chat!". Above it there can be a card "Bottom bar / Top bar": leave that card open.

## The test

**A. Onboarding.** Each screen waits for the one before it; wait for a text before clicking it.

1. The first screen has "Get started": click it.
2. Click the field "Enter profile name…", type `citester`, and click "Create profile".
3. On "Your network", click "Continue".
4. The app explains instant notifications in an alert: click "Allow". Android then asks whether the app may always run in the background: click "Allow" again.
5. Click "Accept" on the conditions screen.
6. Wait up to 60 s for the chat list, which shows "Talk to someone" while there are no conversations. Take a shot.

**B. Four chats.** Create four groups, `group one`, `group two`, `group three` and `group four`, one at a time: click "Start new chat" (the round button in the bottom toolbar), then "Create group"; the name field under "Enter group name:" has the focus: type the name and click "Create group"; wait for "Invite members", which shows once the group exists; then run `ui relaunch`.

1. After the fourth group's `ui relaunch`, take a shot named `four-chats`. Checkpoint **B1**: the four groups are listed; which banner shows, by its title.
2. Run `ui burst before-close 20` and read its contact sheet. Checkpoint **B2**: which banner shows in which frames, and at the end.

**C. Closing "Support SimpleX".** The banner's close button shows only after the banner was opened once.

1. Click "Support SimpleX" (the banner's title): the Support SimpleX screen opens. Take a shot, then `ui key BACK`.
2. Run `ui tree` and find the "Close button" inside the Support SimpleX banner: its y is between the banner's top and bottom, near its right edge (the "Bottom bar / Top bar" card has its own close button: don't click that one). Click it with `ui click <x> <y>`.
3. An alert says "You can support SimpleX later in Settings.": click its "OK" (any case). Take a shot named `closed`. Checkpoint **C1**: the Support SimpleX banner is gone; note what shows in its place, if anything.

**D. Ten starts.** Run `ui burst start-1 20`, read its contact sheet, then the same for `start-2` to `start-10`. Open a single frame (`screens/NN-start-K/<ms>.png`) whenever the sheet is too small to tell what a frame shows.

Checkpoint **D-K**, for each start K: in which frames (by ms) the "Invest in SimpleX Chat!" banner shows, whether it still shows in the last frame and in the text at the end, and whether any other banner shows. A start where the Invest banner shows and later goes away, or goes away and comes back, is a flash.

## Report

Write `report.md` in your working directory: for A to D, each checkpoint's result with its evidence (shot and frame names, positions), then a table of the ten starts (K, frames with the Invest banner, shown at the end, flash: yes or no), the flash rate (starts with a flash out of 10), and anything else unexpected. The test passes when no start has a flash.

End your final message with one line: `CLAUDE-TEST: PASS` if no start has a flash, otherwise `CLAUDE-TEST: FAIL` followed by the flash rate and the starts that had one.

You have at most 150 turns, and the whole test fits in about 60 if you chain steps whose outcome you can predict with `ui do`. For example:

- `ui do click-text "Get started" -- click-text "Enter profile name" 30 -- type citester -- shot profile`
- `ui do click-text "Start new chat" 10 -- click-text "Create group" 10 -- wait "Enter group name" -- type "group one" -- click-text "Create group" 10 -- wait "Invite members" 30 -- relaunch`

`ui do` stops at the first command that fails, so a failed chain tells you where it stopped.

## The ui helper
