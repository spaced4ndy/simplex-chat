# Test: bugs found in 7.1, in the SimpleX Chat desktop app

You are testing the SimpleX Chat desktop app, which runs on a virtual display on this machine. Drive it only with the helpers, through Bash, one command per call: `ui <command> [args]` and `record …`. Anything else is refused; don't look for ways around that, and if something blocks the test, report it. The commands are listed at the end, before the plan.

Your working directory is where your output goes. `ui shot <name>` saves `screens/NN-<name>.png` and prints the text read from it, one phrase per line after its centre `x,y` in screen pixels. Read the PNG to see the screen (1440×900, the app window at the top left). OCR can misread or split words and can't read icons: when the text and the picture disagree, trust the picture, and give an icon's position from the picture. "Above" means a smaller y.

## What is set up

- The app is already running, on its first screen, with a new, empty database: never run `ui start` or `ui stop`. Begin with `ui shot start` to see it.
- After onboarding, the chat list is in the left pane (x 1 to 389) and chats open in the right pane. The toolbar is at the bottom of the left pane, with the profile picture at about 27,730 and a pencil (New chat) at about 363,730.

## Setup: onboarding (case S1)

Each screen waits for the one before it; wait for a text before clicking it. The first screen has "Create your profile": click it. On "Create profile", click the field "Enter profile name", type `citester`, and click "Create profile". The next screen offers a database passphrase: click "Use random passphrase", then "OK" in the alert that follows. Click "Continue", then "Accept" on the screen after it. Wait up to 60 s for the chat list: the right pane shows "Talk to someone". `ui shot S1`.

| ID | Do | Expect |
|---|---|---|
| S1 | Onboarding, as above. | The right pane shows "Talk to someone". |

## How to do things in the app

- **Settings and profiles:** click the profile picture (about 27,730): a menu shows "Your chat profiles" and "Settings". Their sections open in the left pane; press Escape to go back, until the chat list shows.
- **Add a profile:** profile picture → "Your chat profiles" → "Add profile". On "Create profile", click the field about 40 px below the text "Enter your name:", type the name, and click the "Create profile" button (the lower of the two "Create profile" texts; the upper one is the title). The new profile becomes the active one; press Escape until the chat list shows.
- **Restart the app:** `ui relaunch` quits the app and starts it again with its data, as a user restarting it would.

You can chain steps whose outcome you can predict with `ui do`, which stops at the first command that fails, for example `ui do click 27 730 -- click-text Settings 10 -- shot settings`. Take a shot at each check, named after its case (`ui shot H3-after-save`).

## Report

Write `report.md` in your working directory as you go, so a session that is cut short still leaves its results: one row per case of "This session", PASS or FAIL with its evidence (the text OCR read, what the picture shows, screenshot names), and anything else unexpected. Record each case with `record` as soon as it is done. End your final message with one line: `CLAUDE-TEST: PASS` if every check you ran passed, otherwise `CLAUDE-TEST: FAIL` followed by the cases that failed.

## The ui helper
