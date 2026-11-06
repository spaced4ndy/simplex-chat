# Plan: the QR scanner with a camera

This emulator has a virtual back camera. These cases record that the scanner opens the camera and that closing it leaves the camera closed, for a reviewer who reads the screenshots and the output of `ui camera`. `ui wait "no such text" <secs>` fails after that time and is only a pause. Copy the output of `ui camera` into the case's `record` note. Run the cases in this order, and go on after a case that shows a bug. The chat list shows before K1 and K5.

| ID | Do | Expect |
|---|---|---|
| K1 | `ui do click-text "Start new chat" -- click-text "Paste link / Scan" 10 -- wait "Or scan QR code" 20`. `ui wait "no such text" 8`. `ui shot K1-open`. `ui camera`. | The camera's area shows an image from the virtual camera (a moving scene or a pattern), and `ui camera` lists an active client. |
| K2 | `ui key BACK`. `ui wait "no such text" 5`. `ui shot K2-closed`. `ui camera`. | "New chat" shows, with no alert, and `ui camera` lists no active client. |
| K3 | Open and close at once: `ui do click-text "Paste link / Scan" 10 -- key BACK`. `ui wait "no such text" 5`. `ui shot K3-closed`. `ui camera`. | "New chat" shows, with no alert, and `ui camera` lists no active client. |
| K4 | Open, close and open again at once: `ui do click-text "Paste link / Scan" 10 -- wait "Or scan QR code" 20 -- key BACK -- click-text "Paste link / Scan" 10 -- wait "Or scan QR code" 20`. `ui wait "no such text" 8`. `ui shot K4-open`. `ui camera`. Then `ui key BACK`, `ui wait "no such text" 5`, `ui shot K4-closed`, `ui camera`. Then back to the chat list. | With the scanner open, the camera's area shows the image and a client is active; after BACK, no client is active. |
| K5 | The first open after a start, closed at once: `ui do relaunch -- click-text "Start new chat" -- click-text "Paste link / Scan" 10 -- key BACK`. `ui wait "no such text" 8`. `ui shot K5-closed`. `ui camera`. | "New chat" shows, with no alert, and `ui camera` lists no active client. |
