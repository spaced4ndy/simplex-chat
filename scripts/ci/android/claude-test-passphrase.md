# Test: changing the database passphrase, ten times

You are testing the SimpleX Chat Android app, which runs in an Android emulator on this machine. Drive it only with the `ui` helper, through Bash, one command per call: `ui <command> [args]`. Anything else is refused; don't look for ways around that, and if something blocks the test, report it. The commands are listed at the end.

The question is whether a passphrase change can hang: no "Database encrypted!" and no error alert after the change is confirmed, with the screen busy. It happens only sometimes, so the test repeats the change and records each attempt; a hang is a result to record, not a reason to stop.

Your working directory is where your output goes. `ui shot <name>` saves `screens/NN-<name>.png` and prints the text on screen, one element per line after its centre `x,y` in screen pixels. Read the PNG to see the screen (1080x2400). The text comes from the app's accessibility tree, so it is spelled exactly, but it can list an element that another screen covers: when the text and the picture disagree, trust the picture. `ui tree` also lists elements without a text: buttons such as the eye button of a passphrase field, and the progress indicator of a busy screen. Every `ui` command is logged with its UTC time in `screens/steps.log`: use those times to say how long each change took.

## What is set up

- The app is already running, on its first screen, with a new database encrypted with a random passphrase: never run `ui start` or `ui stop`. Begin with `ui shot start` to see it.
- `ui type` types into the field that has the focus, and checks that the field then shows the text. A passphrase field hides its text, so before typing into one, tap its eye button (at the field's right edge, found with `ui tree`) so that it shows the text, then tap the field to focus it, then type. The eye buttons stay where they are while the screen keeps its fields, so find their positions once per layout and reuse them.
- After a change, the fields keep showing the old text although they were cleared (a known display issue, not what this test is about): that is why each attempt below starts on a freshly opened screen.
- `ui key BACK` is Android's back button.

## The test

**A. Onboarding.** Each screen waits for the one before it; wait for a text before clicking it.

1. The first screen has "Get started": click it.
2. Click the field "Enter profile name…", type `citester`, and click "Create profile".
3. On "Your network", click "Continue".
4. The app explains instant notifications in an alert: click "Allow". Android then asks whether the app may always run in the background: click "Allow" again.
5. Click "Accept" on the conditions screen.
6. Wait up to 60 s for "Talk to someone".

**B. The passphrase screen.** Click "profile image placeholder" (the profile button in the toolbar), then "Settings", "Chat data", "Database passphrase & export" and "Database passphrase". Take a shot named `passphrase-random`. Checkpoint **B1**: the screen has "New passphrase…" and "Confirm new passphrase…" but no "Current passphrase…", and its text below says the database is encrypted using a random passphrase.

**C. The first passphrase.**

1. Type `Passw0rd-1` into "New passphrase…" and into "Confirm new passphrase…" (each shown with its eye button first), then click "Update database passphrase".
2. An alert "Change database passphrase?" opens: click its "Update". Then run `ui wait "Database encrypted!" 120`.
3. Checkpoint **C1**: whether "Database encrypted!" showed, and how many seconds after "Update" (steps.log). If it showed, take a shot named `encrypted-1` and click "OK". If it didn't, follow **H** below.

**D. Nine changes, each after a wrong attempt.** For K = 1 to 9, the current passphrase is `Passw0rd-K` and the new one `Passw0rd-N`, where N = K + 1. The screen now has three fields: "Current passphrase…", "New passphrase…" and "Confirm new passphrase…".

0. Leave the screen with `ui key BACK` and open it again with "Database passphrase".
1. The wrong attempt: type `Wrong-K` into "Current passphrase…", `Passw0rd-N` into "New passphrase…" and into "Confirm new passphrase…", click "Update database passphrase", then "Update" in the alert, and run `ui wait "Wrong passphrase!" 120`. Checkpoint **DK-a**: whether "Wrong passphrase!" ("Please enter correct current passphrase.") showed, and after how many seconds. Click "OK".
2. Leave the screen with `ui key BACK` and open it again with "Database passphrase".
3. The change: type `Passw0rd-K` into "Current passphrase…", `Passw0rd-N` into "New passphrase…" and into "Confirm new passphrase…", click "Update database passphrase", then "Update" in the alert, and run `ui wait "Database encrypted!" 120`. Checkpoint **DK-b**: whether "Database encrypted!" showed, and after how many seconds after "Update". If it showed, take a shot named `encrypted-N` and click "OK". If it didn't, follow **H**.

**H. When an alert doesn't show within 120 s** (a hang):

1. Take a shot named `hang-<checkpoint>` and run `ui tree`: record whether the progress indicator shows, which fields still hold text, and whether "Update database passphrase" looks enabled.
2. Run `ui wait "Database encrypted!" 60` once more (for a change; "Wrong passphrase!" for a wrong attempt), and record whether it showed late, with its time.
3. If still nothing: run `ui relaunch` (it may time out waiting for the chat list) and take a shot named `after-hang-<checkpoint>`. Record what the start shows: the chat list, or "Encrypted database" asking for the passphrase.
4. If it asks for the passphrase: type the new passphrase into its field (shown with its eye button first) and click "Open chat"; if "Wrong passphrase!" shows, click "OK" and try the current one instead. Record which passphrase opened the chat, or that neither did; if neither did, stop the test there and report.
5. Open the passphrase screen again (as in B) and carry on with the next attempt, taking as the current passphrase the one that opened the chat (the new one if the chat list showed without asking).

## Report

Write `report.md` in your working directory: each checkpoint's result with its evidence (shot names, times from steps.log), then a table of every attempt (checkpoint, wrong attempt or change, alert shown: yes, late or no, seconds), the hang rate (attempts without their alert within 120 s, out of all attempts, wrong ones counted separately from the changes), and for each hang what H found.

End your final message with one line: `CLAUDE-TEST: PASS` if every attempt showed its alert within 120 s, otherwise `CLAUDE-TEST: FAIL` followed by the hang rate and the checkpoints that hung, or the checkpoint where the test had to stop.

You have at most 200 turns. Chain steps whose outcome you can predict with `ui do`, which stops at the first command that fails. For example, once the eye buttons' positions are known (here at x 1000 and the fields' y, which you read from `ui tree`):

- `ui do click-text "Get started" -- click-text "Enter profile name" 30 -- type citester -- shot profile`
- `ui do click 1000 <y1> -- click-text "Current passphrase" -- type Wrong-1 -- click 1000 <y2> -- click-text "New passphrase" -- type Passw0rd-2 -- click 1000 <y3> -- click-text "Confirm new passphrase" -- type Passw0rd-2 -- click-text "Update database passphrase" -- click-text Update 10`

## The ui helper
