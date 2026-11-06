# Plan: About opened from Settings

These cases capture what the app shows, for a reviewer who compares the screenshots. Take every shot the plan names, exactly when it says, and in each `record` note quote the texts you saw. Record a case ok when its shots are taken and its Expect holds, and bug when it does not, with what you saw; the reviewer decides from the screenshots. Do not run a case recorded bug a second time, even when `record` suggests it: go on to the next case.

The app starts with the bottom bar, the default. Settings: tap your profile picture at the bottom left of the chat list, then "Settings"; scroll down to "About SimpleX Chat". `ui key BACK` goes back.

| ID | Do | Expect |
|---|---|---|
| A1 | Settings → "About SimpleX Chat": `ui shot A1-about`. | "Why SimpleX is built." shows above the bottom bar with the back arrow, and nothing covers it. |
| A2 | Tap "Why SimpleX is built.": `ui shot A2-why`. Scroll the text to its end with `ui swipe`: `ui shot A2-why-end`. `ui key BACK`: `ui shot A2-back-on-about`. | "You were born without an account" shows. At the end, "Be free in your network." is above the bottom bar, not covered. Back returns to About. |
| A3 | `ui key BACK` until Settings shows. Settings → "Appearance" → turn off "Reachable app toolbars". Go back to Settings, open "About SimpleX Chat": `ui shot A3-about-top-bar`. Tap "Why SimpleX is built.": `ui shot A3-why-top-bar`. `ui key BACK`: `ui shot A3-back-on-about`. | The back arrow is at the top; the link shows at the bottom with nothing covering it; the text opens, and back returns to About. |
