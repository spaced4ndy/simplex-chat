# Test: the What's new page in the SimpleX Chat Android app

You are testing the SimpleX Chat Android app, which runs in an Android emulator on this machine. Drive it only with the `ui` helper, through Bash, one command per call: `ui <command> [args]`. Anything else is refused; don't look for ways around that, and if something blocks the test, report it. The commands are listed at the end.

Your working directory is where your output goes. `ui shot <name>` saves `screens/NN-<name>.png` and prints the text on screen, one element per line after its centre `x,y` in screen pixels. Read the PNG to see the screen (1080×2400). The text comes from the app's accessibility tree, so it is spelled exactly, but it can list an element that another screen covers: when the text and the picture disagree, trust the picture. "Above" means a smaller y. `ui tree` also lists text fields and buttons that have no text.

## What is set up

- The app is already running, on its first screen, with a new, empty database: never run `ui start` or `ui stop`. Begin with `ui shot start` to see it.
- `ui type` types into the field that has the focus: tap a field before typing into it. `ui key BACK` is Android's back button.
- The chat list shows the app's own cards as list items until they are closed, such as "Bottom bar / Top bar" and "Invest in SimpleX Chat!": leave them open.

## The test

**A. Onboarding.** Each screen waits for the one before it; wait for a text before clicking it. If the What's new page opens by itself at any point, take a shot of it (`ui shot whats-new-at-start`), then close it and continue.

1. The first screen has "Get started": click it.
2. Click the field "Enter profile name…", type `citester`, and click "Create profile".
3. On "Your network", click "Continue".
4. The app explains instant notifications in an alert: click "Allow". Android then asks whether the app may always run in the background: click "Allow" again.
5. Click "Accept" on the conditions screen.
6. Wait up to 60 s for the chat list, which shows "Talk to someone" while there are no conversations.

**B. What's new, light theme.**

1. Open the app's Settings: it is reached from your profile picture in the toolbar. In Settings, scroll to "What's new" and click it. Wait for "New in v7.1", then take a shot named `whats-new-light`.
2. If the page continues below the screen, scroll down and take a shot named `whats-new-light-end`.
3. Check, noting the evidence (screenshot names, positions):
   - the title is "New in v7.1";
   - these items follow it, in this order: "Supporter badge", "Safer channels", "Terminal chat layout", "Markdown formatting", "Better calls", then "Read more";
   - the badge's picture is to the right of the "Supporter badge" text, and overlaps neither the title "New in v7.1" nor any text;
   - the gap below the "Supporter badge" text, to "Safer channels", looks about the same as the gaps between the items below it;
   - nothing is cut off, overlapping or garbled.

**C. What's new, dark theme.**

1. Close What's new, open "Appearance" in Settings, and set the theme to dark. Go back to Settings, open "What's new" again, wait for "New in v7.1", and take a shot named `whats-new-dark`, and `whats-new-dark-end` if the page continues below the screen.
2. Repeat the checks of B.

You have at most 60 turns, and the whole test fits in about 25 if you chain steps whose outcome you can predict with `ui do` and look at the screen after each chain. For example:

- `ui do click-text "Get started" -- click-text "Enter profile name" 30 -- type citester -- shot profile`
- `ui do click-text "Create profile" -- wait Continue 60 -- shot your-network`

`ui do` stops at the first command that fails, so a failed chain tells you where it stopped.

## Report

Write `report.md` in your working directory: for each of A, B and C, each check you ran as PASS or FAIL with its evidence, and anything else unexpected. End your final message with one line: `CLAUDE-TEST: PASS` if every check you ran passed, otherwise `CLAUDE-TEST: FAIL` followed by the checks that failed.

## The ui helper
