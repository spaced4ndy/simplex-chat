# Test: the Redeem code screen on a phone and on a tablet in landscape

You are testing the SimpleX Chat Android app, which runs in an Android emulator on this machine. Drive it only with the `ui` helper, through Bash, one command per call: `ui <command> [args]`. Anything else is refused; don't look for ways around that, and if something blocks the test, report it. The commands are listed at the end.

Your working directory is where your output goes. `ui shot <name>` saves `screens/NN-<name>.png` and prints the text on screen, one element per line after its centre `x,y` in screen pixels. Read the PNG to see the screen. The text comes from the app's accessibility tree, so it is spelled exactly, but it can list an element that another screen covers: when the text and the picture disagree, trust the picture. "Above" means a smaller y. `ui find <text>` prints an element's centre and its bounds: `x y left top right bottom`.

## What is set up

- The app is already running, on its first screen, with a new, empty database: never run `ui start` or `ui stop`. Begin with `ui shot start` to see it.
- The emulator's screen is a phone in portrait, 1080x2400 px. `ui display tablet` turns it into a tablet in landscape, 2400x1080 px (1777x800 dp); `ui display phone` turns it back. Screenshots, text positions and taps use the same pixels as the screen in both.
- `ui type` types into the field that has the focus: tap a field before typing into it. `ui key BACK` is Android's back button.
- This emulator has no camera. The Redeem code screen shows a square camera area for scanning a code; here it is empty or black. Leaving the Redeem code screen, or changing the display while it is open, freezes the app for about 30 s and then shows "View crashed": that is a separate, known bug, not part of this test. So change the display only on the chat list, and never leave the Redeem code screen except by `ui relaunch`. If the crash shows anyway, note it, run `ui relaunch`, and carry on.
- After each `ui relaunch`, run `ui display` again with the screen you want, before anything else.

## The test

**A. Onboarding.** Each screen waits for the one before it; wait for a text before clicking it.

1. The first screen has "Get started": click it.
2. Click the field "Enter profile name…", type `citester`, and click "Create profile".
3. On "Your network", click "Continue".
4. The app explains instant notifications in an alert: click "Allow". Android then asks whether the app may always run in the background: click "Allow" again.
5. Click "Accept" on the conditions screen.
6. Wait up to 60 s for the chat list, which shows "Talk to someone" while there are no conversations. Take a shot.

**C. The Redeem code screen on a tablet in landscape.** C comes before B.

1. On the chat list, run `ui display tablet` and take a shot named `tablet-chat-list`.
2. Click "profile image placeholder" (the profile button in the toolbar), then "Settings", then "Support SimpleX" (the row with the badge image). Wait for "Redeem badge code" and take a shot named `support-tablet`.
3. Click "Redeem badge code" and wait for "Paste the code you received.". Take a shot named `redeem-tablet-top`.
4. Checkpoint **C1 redeem-tablet-top**: run `ui find "Paste"` and `ui find "Redeem"` (the button at the bottom; the title is "Redeem code"), and note their bounds or that one is not on screen. From the picture, note where the square camera area ends (its bottom y) and what is between it and the bottom of the screen.
5. Scroll down one swipe at a time with `ui scroll 1200 900 down 1`, taking a shot after each (`redeem-tablet-scroll-1`, `redeem-tablet-scroll-2`, ...), until "Redeem" (the button) is on screen, or after 8 swipes. If it is on screen already, take one swipe and its shot anyway.
6. Checkpoint **C2 redeem-tablet-button**: how many swipes it took until the Redeem button showed (0 if it was on screen at once); on the first shot that shows it, the bounds of "Redeem" (`ui find "Redeem"`), the bottom of the camera area from the picture, and the gap between them in pixels. If the camera area scrolled off the top, say so and estimate the gap from the shots before.

**B. The same screen on the phone.**

1. Run `ui relaunch`, then `ui display phone`, and take a shot named `phone-chat-list`.
2. Click "profile image placeholder", then "Settings", then "Support SimpleX". Wait for "Redeem badge code" and take a shot named `support-phone`.
3. Click "Redeem badge code" and wait for "Paste the code you received.". Take a shot named `redeem-phone`.
4. Checkpoint **B1 redeem-phone**: run `ui find "Paste"` and `ui find "Redeem"`, and note their bounds. From the picture, note where the square camera area ends and whether the Redeem button is on screen without scrolling. Gap = the top of the Redeem button minus the bottom of the camera area, in pixels.

You have at most 150 turns, and the whole test fits in about 40 if you chain steps whose outcome you can predict with `ui do` and look at the screen after each chain. For example:

- `ui do click-text "Get started" -- click-text "Enter profile name" 30 -- type citester -- shot profile`
- `ui do click-text "Create profile" -- wait Continue 60 -- shot your-network`
- `ui do click-text "profile image placeholder" 10 -- click-text Settings 10 -- click-text "Support SimpleX" 10 -- wait "Redeem badge code" 20 -- shot support-tablet`

`ui do` stops at the first command that fails, so a failed chain tells you where it stopped.

## Report

Write `report.md` in your working directory: for A, C and B, each step's result with its evidence (shot names, bounds from `ui find`, the gaps in pixels), and anything else unexpected. The test passes when both of these hold:

- B1: on the phone, the Redeem button is on screen without scrolling (here the space above it is meant to fill the screen, so its gap is only noted);
- C2: on the tablet, the Redeem button is on screen after at most one swipe, and the gap between the camera area and it is under 300 px.

End your final message with one line: `CLAUDE-TEST: PASS` if both hold, otherwise `CLAUDE-TEST: FAIL` followed by the checkpoint that failed and the measured gap and swipe count.

## The ui helper
