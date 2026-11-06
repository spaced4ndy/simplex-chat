# Test: bugs found in 7.1, in the SimpleX Chat Android app

You are testing the SimpleX Chat Android app, which runs in an Android emulator on this machine. Drive it only with the helpers, through Bash, one command per call: `ui <command> [args]`, `record …` and `peer …`. Anything else is refused; don't look for ways around that, and if something blocks the test, report it. The commands are listed at the end, before the plan.

Your working directory is where your output goes. `ui shot <name>` saves `screens/NN-<name>.png` and prints the text on screen, one element per line after its centre `x,y` in screen pixels. Read the PNG to see the screen (1080×2400). The text comes from the app's accessibility tree, so it is spelled exactly, but it can list an element that another screen covers: when the text and the picture disagree, trust the picture. "Above" means a smaller y. `ui tree` also lists text fields and buttons that have no text.

## What is set up

- The app is already running, on its first screen, with a new, empty database: never run `ui start` or `ui stop`. Begin with `ui shot start` to see it.
- `ui type` types into the field that has the focus: tap a field before typing into it. `ui key BACK` is Android's back button.
- Besides the chats, the chat list shows the app's own cards as list items until they are closed ("Bottom bar / Top bar", "Invest in SimpleX Chat!" and others): leave them open.

## Setup: onboarding (case S1)

Each screen waits for the one before it; wait for a text before clicking it. The first screen has "Get started": click it. Click the field "Enter profile name…", type `citester`, and click "Create profile". On "Your network", click "Continue". The app explains instant notifications in an alert: click "Allow"; Android then asks whether the app may always run in the background: click "Allow" again. Click "Accept" on the conditions screen. Wait up to 60 s for the chat list, which shows "Talk to someone" while there are no conversations. `ui shot S1`.

| ID | Do | Expect |
|---|---|---|
| S1 | Onboarding, as above. | The chat list shows "Talk to someone". |

You can chain steps whose outcome you can predict with `ui do`, which stops at the first command that fails, for example `ui do click-text "Get started" -- click-text "Enter profile name" 30 -- type citester -- shot profile`. Take a shot at each check, named after its case.

## Report

Write `report.md` in your working directory as you go, so a session that is cut short still leaves its results: one row per case of "This session", PASS or FAIL with its evidence (element texts, what the picture shows, screenshot names), and anything else unexpected. Record each case with `record` as soon as it is done. End your final message with one line: `CLAUDE-TEST: PASS` if every check you ran passed, otherwise `CLAUDE-TEST: FAIL` followed by the cases that failed.

## The ui helper
