# Test: which chat list banner shows at the onboarding cards, with four chats, after closing "Support SimpleX", and at three starts

You are testing the SimpleX Chat Android app, which runs in an Android emulator on this machine. Drive it only with the `ui` helper, through Bash, one command per call: `ui <command> [args]`. Anything else is refused; don't look for ways around that, and if something blocks the test, report it. The commands are listed at the end.

This test records which banner the app shows at each checkpoint; it doesn't judge whether that is right, so record exactly what you see, including "no banner".

Your working directory is where your output goes. `ui shot <name>` saves `screens/NN-<name>.png` and prints the text on screen, one element per line after its centre `x,y` in screen pixels. Read the PNG to see the screen (1080x2400). The text comes from the app's accessibility tree, so it is spelled exactly, but it can list an element that another screen covers: when the text and the picture disagree, trust the picture. "Above" means a smaller y. `ui tree` also lists buttons that have no text, such as "Close button".

`ui burst <name> <secs>` restarts the app and takes screenshots as fast as the emulator gives them, for secs seconds from the restart: each is `screens/NN-<name>/<ms>.png`, named by the milliseconds since the restart, and `screens/NN-<name>.png` is a contact sheet of them all in order, each labelled with its ms. It then prints the text on screen at the end.

## What is set up

- The app is already running, on its first screen, with a new, empty database: never run `ui start` or `ui stop`. Begin with `ui shot start` to see it.
- `ui type` types into the field that has the focus: tap a field before typing into it. `ui key BACK` is Android's back button.
- There are two banners, each a rounded box with a title, a subtitle and a picture on its right: "Invest in SimpleX Chat!" (subtitle "Crowdfunding on Wefunder") and "Support SimpleX" (subtitle "Get badge + better files"). The app may show one of them or neither. Without conversations, a banner can show below the two cards of "Talk to someone"; in the chat list, near its top, as a list item. Above it in the chat list there can be a card "Bottom bar / Top bar": leave that card open.

## The test

**A. Onboarding.** Each screen waits for the one before it; wait for a text before clicking it.

1. The first screen has "Get started": click it.
2. Click the field "Enter profile name…", type `citester`, and click "Create profile".
3. On "Your network", click "Continue".
4. The app explains instant notifications in an alert: click "Allow". Android then asks whether the app may always run in the background: click "Allow" again.
5. Click "Accept" on the conditions screen.
6. Wait up to 60 s for "Talk to someone", which shows while there are no conversations, and take a shot named `onboarding-cards`. Checkpoint **A1**: which banner shows below the two cards, by its title and position, or that none does.
7. Run `ui burst onboarding 15` and read its contact sheet. Checkpoint **A2**: in which frames (by ms) a banner shows below the cards, which one, and whether it shows in the last frame and in the text at the end.

**B. Four chats.** Create four groups, `group one`, `group two`, `group three` and `group four`, one at a time: click "Start new chat" (the round button in the bottom toolbar), then "Create group"; the name field under "Enter group name:" has the focus: type the name and click "Create group"; wait for "Invite members", which shows once the group exists; then run `ui relaunch`.

1. After the fourth group's `ui relaunch`, take a shot named `four-chats`. Checkpoint **B1**: the four groups are listed; which banner shows near the top of the list, by its title, or that none does.

**C. Closing "Support SimpleX"**, only if B1 showed it; otherwise write "C skipped: no Support SimpleX banner" and go to D. The banner's close button shows only after the banner was opened once.

1. Click "Support SimpleX" (the banner's title): the Support SimpleX screen opens. Take a shot, then `ui key BACK`.
2. Run `ui tree` and find the "Close button" inside the Support SimpleX banner: its y is between the banner's top and bottom, near its right edge (the "Bottom bar / Top bar" card has its own close button: don't click that one). Click it with `ui click <x> <y>`.
3. An alert says "You can support SimpleX later in Settings.": click its "OK" (any case). Take a shot named `closed`. Checkpoint **C1**: the Support SimpleX banner is gone; note what shows in its place, if anything.

**D. Three starts.** Run `ui burst start-1 15`, read its contact sheet, then the same for `start-2` and `start-3`. Open a single frame (`screens/NN-start-K/<ms>.png`) whenever the sheet is too small to tell what a frame shows.

Checkpoint **D-K**, for each start K: in which frames (by ms) a banner shows and which one, whether it still shows in the last frame and in the text at the end. A start where a banner shows and later goes away, or goes away and comes back, is a flash: say so.

## Report

Write `report.md` in your working directory: for A to D, each checkpoint's result with its evidence (shot and frame names, positions), then a table of the starts (A2 and D-1 to D-3: frames with a banner and which, shown at the end, flash: yes or no), and anything else unexpected.

End your final message with one line: `CLAUDE-TEST: PASS` if every checkpoint was reached and recorded, otherwise `CLAUDE-TEST: FAIL` followed by the checkpoint where the test stopped and why.

You have at most 100 turns, and the whole test fits in about 45 if you chain steps whose outcome you can predict with `ui do`. For example:

- `ui do click-text "Get started" -- click-text "Enter profile name" 30 -- type citester -- shot profile`
- `ui do click-text "Start new chat" 10 -- click-text "Create group" 10 -- wait "Enter group name" -- type "group one" -- click-text "Create group" 10 -- wait "Invite members" 30 -- relaunch`

`ui do` stops at the first command that fails, so a failed chain tells you where it stopped.

## The ui helper
