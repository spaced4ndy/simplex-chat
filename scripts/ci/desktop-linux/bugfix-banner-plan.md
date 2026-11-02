# Plan: the chat list banner's close button in the dark theme

The chat list shows one banner at a time: "Invest in SimpleX Chat!" ("Crowdfunding on Wefunder"), or "Support SimpleX" ("Get badge + better files") once the profile has more than 3 chats. A banner shows its close button, an "X" at its top right corner, only after the banner was clicked once. Only one banner shows per app start: after a banner has shown, another one appears only after `ui relaunch`.

These cases capture how the X looks, in the dark and the light theme, for a reviewer who compares the screenshots of runs before and after a change. Take every shot the plan names, exactly when it says, with the banner fully visible and nothing over it (no menu, no dialog, the mouse pointer away from it: `ui click` an empty part of the right pane first if needed). OCR does not read the X: look at the picture and give the X's position and colours in the record.

| ID | Do | Expect |
|---|---|---|
| B1 | Settings → "Appearance". Click the "Color mode" row and choose "Dark". Press Escape until the chat list shows. `ui shot B1-dark`. | The app is drawn dark: a black background, light text. |
| B2 | The profile has no conversations yet, so the right pane shows the onboarding pages ("Talk to someone") with "Invest in SimpleX Chat!" below them. Click that banner; a page about investing opens: `ui shot B2-invest-page`, then press Escape to close it. | The page opened and closed; "Talk to someone" shows again. |
| B3 | Create the group `g1`, and press Escape until the chat list shows. The left pane lists "g1" and shows "Invest in SimpleX Chat!" with its X at the banner's top right: `ui shot B3-invest-dark`. | The X stands out clearly from the banner behind it. Say what colours you see for the X and for the banner right around it. |
| B4 | Create the groups `g2` and `g3`. `ui relaunch`, then wait up to 30 s for "Support SimpleX" in the chat list (`ui wait "Support SimpleX" 30`). Click the banner; a page about supporter badges opens: `ui shot B4-support-page`, then press Escape until the chat list shows. The banner now shows its X: `ui shot B4-support-dark`. | The list shows g1, g2 and g3. The "Support SimpleX" banner shows its X at its top right, and the X stands out clearly from the banner behind it. Say what colours you see for the X and for the banner around it. |
| B5 | Settings → "Appearance" → "Color mode" → "Light"; press Escape until the chat list shows: `ui shot B5-support-light`. Then set "Color mode" back to "Dark" the same way: `ui shot B5-support-dark-again`. | In the light theme the X shows grey on the light banner. Back in the dark theme the banner and its X look as in B4. |

Record a case ok when its shots are taken and its Expect holds, and bug when the X does not stand out from the banner behind it, with the colours you saw; the reviewer decides from the screenshots in either case.
