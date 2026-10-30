# Release regression: iOS

## On iOS, for these cases

- In this run results go to `record`, not to a Results table: skip the Results table and the `todo` rows that "The report" above describes; `report.md` holds only the line on the app at the start, `## Findings` and `## Harness notes`.
- **Give the app a link:** `ui clipboard '<link>'`, then paste it where the case says: in the search field (tap it once to focus it, once more for its menu, then "Paste"), or "Compose" → "Scan / Paste link" → "Tap to paste link" (tap "Allow Paste" if iOS asks). `ui open-link '<link>'` opens a link as another app would.
- **Get a link from the app:** its "Copy" button, or "Share link" and "Copy" in the share sheet; then `ui clipboard` prints it.
- A message's menu: `ui long-press` on the message's text; a chat's actions in the list: swipe its row (`ui swipe`) or long-press it.

## The regression cases

The cases of this session (the table at the end) come from the team's release regression table: each is one line written for a person who knows the app, not a list of steps. For each case, work out the shortest way to check what it says in this app, do it, check it, and record the result at once.

1. Read the case. Where it names a gesture of another platform ("swipe (ios) / long press (android)"), use this app's own way to do the same. A case about a version upgrade, a camera, a microphone, a call, push notifications, a second device, a purchase or a badge code is `manual`: record what it needs. Where only a part of a case needs such a thing, check the rest, and say in the note which part was not checked.
2. Set up what the case needs: contacts, groups and channel subscribers are CLI peers (below); messages, settings and profiles you make in the app.
3. Do it, and check each thing the case says. Take `ui shot <row>-<what>` at the moment that shows the result (the name has only letters, digits, - and _).
4. Record it: `record <row> <ok|bug|blocked|manual> "<what you saw, in one line>" <screenshot name>`.
   - ok: everything the case says held, as you saw it.
   - bug: the app did something wrong; the note says what you did, what you saw and what you expected.
   - blocked: this runner or a helper stopped the case (say what: the peer couldn't connect, the screen couldn't be read, the app crashed at start).
   - manual: the case needs something no runner has; say what.
5. Spend at most about 20 turns on one case: when it is stuck, record it `blocked` with what stopped it, and go on.

Run the cases in the table's order, but leave to the end any case that wipes the app (deleting the database, a self-destruct passcode, deleting the last profile), since the cases after it would start from nothing.

After the last case, run each case recorded `bug` once more, from the start of its steps: record it again, `bug` if it failed again, or `ok` with "passed on retry; first attempt: <what happened>". A case is a bug only after it failed twice.

`report.md` in your directory: one line on the app at the start, `## Findings` with each bug in detail (steps, what you saw, what you expected, screenshots) and `## Harness notes` for anything about the helpers or the runner that got in the way. Results go only to `record`; `record` alone prints what is recorded, so after the conversation has been compacted, run it to see which cases are left, and read `prompt.md` again for the rest.

The session is done when every case of the table is recorded. Your final message: the counts of ok, bug, blocked and manual, and the most important bug, then one more line: `CLAUDE-TEST: PASS` if no case is recorded bug, otherwise `CLAUDE-TEST: FAIL` and the rows recorded bug.

## Peers: the other people in a case

The `peer` helper runs CLI clients that act as contacts, group members and channel subscribers. Name each after a person (alice, bob, carol, dave, eve, …); a peer keeps its contacts, groups and messages for the whole session, so use new names when a case needs people who don't know the app yet. The app's profile is "citester": that is the name peers know it by.

- **A peer is online only while one of its commands runs.** What the app sends while it is offline reaches it at its next command. So after the app does something a peer must answer (accept a connection, join, deliver, read), run `peer <name> wait 20`, or `peer <name> messages '@citester'` to see what arrived. A group the app joins from a peer's link or invitation needs the peer, its host, online: run `peer <host> wait 30` after the app joins.
- **The app connects to a peer:** `peer alice link` (a 1-time link) or `peer alice address` prints a link; give it to the app (below), then `peer alice wait 20` so the connection completes; the app then shows the contact alice.
- **A peer connects to the app:** make a link in the app (1-time link, address, group link, channel link), get its text (below), then `peer bob connect '<link>'`; accept in the app if it asks, then `peer bob wait 20`.
- **Groups:** the app creates the group and adds peer contacts (`peer bob join '#<group>'` accepts the invitation, then `peer bob wait 20`), or a peer creates one (`peer bob group team`, `peer bob invite '#team' '@citester'`) and the app accepts.
- **Messages from peers:** `peer bob send '@citester' 'hello'`; several arguments make a multi-line message; `image`, `file`, `text-file` and `voice` send attachments; `reply`, `react`, `edit`, `delete` act on messages by their text.
- Quote every argument that starts with # or @ or contains spaces or punctuation: `peer bob send '#team' 'hi (all)'`.

## Cases

| Row | Section | Case |
|---|---|---|
| 134 | editing and deletion | group moderation - message is deleted if admin deletes it |
| 135 | editing and deletion | group moderation - message is permanently deleted / marked deleted according to preference |
| 136 | editing and deletion | group moderation - moderated message can be deleted for youself |
| 137 | editing and deletion | group moderation - can't delete other member's message if his role is higher |
| 138 | editing and deletion | irreversibly delete for recipient (preference) |
| 139 | editing and deletion | multi delete - local / for recipient / moderation |
| 140 | editing and deletion | multi delete - if received messages or non content events are selected can only delete locally |
| 141 | editing and deletion | multi delete - can include own messages for moderation if other messages are selected |
| 142 | editing and deletion | send live message - updated on recipient side |
| 143 | editing and deletion | alert is shown before sending live message for the first time |
| 144 | editing and deletion | typing indicator is shown for sender and recipient |
| 145 | editing and deletion | live messages are not marked as edited |
| 146 | editing and deletion | edit live message after complete (should be prohibited while live / should complete live?) |
| 147 | editing and deletion | delete live message after complete (should be prohibited while live / should complete live?) |
| 148 | editing and deletion | quote live message after complete (should be prohibited while live / should complete live?) |
| 149 | editing and deletion | delete live message while live on recipient side - created as new |
| 150 | editing and deletion | quote live message while live on recipient side - quoted with updated content |
| 151 | editing and deletion | start live message when text is typed (long press send button) |
| 152 | editing and deletion | start live message with attachment added (e.g. image) - by long-pressing send button |
| 153 | editing and deletion | send disappearing message - deleted for both after ttl (on recipient side after read) |
| 154 | editing and deletion | disappearing message is deleted on time after chat restart, after re-opening from background |
| 155 | editing and deletion | if ttl changes messages with non default ttl display it |
| 156 | editing and deletion | edit disappearing message |
| 157 | editing and deletion | delete disappearing message |
| 158 | editing and deletion | quote disappearing message |
| 159 | editing and deletion | send live disappearing message, disappearance scheduled after live message is finished |
| 160 | editing and deletion | send disappearing message with custom time (long press send) |
| 161 | editing and deletion | send disappearing message with custom time allowed if conversation setting allows but timer is not set |
| 162 | editing and deletion | disappearing message with 12 months interval - correct disappearing time in info |
| 163 | editing and deletion | set custom disappearing message time - for contact, for group |
| 164 | editing and deletion | chat item info view - own / other's chat item, history, share text |
| 165 | editing and deletion | chat item info view - delivery statuses for sent group messages |
| 166 | editing and deletion | chat item info view - original (quoted) message |
| 167 | editing and deletion | chat item info view - show file servers used to deliver a file |
| 169 | link previews | generate link preview, send and receive, check after reopen |
| 170 | link previews | changing link or link's text before sending (faster than link preview updated) sends message without link preview |
| 171 | link previews | editing link preview updates link preview on recipient's side accordingly (changes/removes it) |
| 172 | link previews | cancel link preview |
| 173 | link previews | link preview spinner |
| 175 | chat view | group - member avatar is shown only once per series |
| 176 | chat view | group - member name is shown only once per series on specific items (e.g. not shown for events) |
| 177 | chat view | group - member connected items in a row are aggregated to a single item, with updating members list |
| 178 | chat view | feature items are aggregated (connect with contact) |
| 179 | chat view | clicking avatar opens member information |
| 181 | chat view | messages are grouped by time (time is shown on last message in group of close messages) |
| 182 | chat view | date separators and floating date are displayed when scrolling back in time |
| 185 | chat view | content filter - media, links, etc. |
| 186 | chat view | navigate to message filtered via content filter |
| 193 | user contact address | create address |
| 194 | user contact address | delete address, shows alert |
| 196 | user contact address | accept request via tap in chat list - should add pending contact, then connect |
| 197 | user contact address | accept request via swipe (ios) / long press (android) |
| 198 | user contact address | accept request from new chat sheet |
| 200 | user contact address | accept request with the requesting client offline, then restart |
| 201 | user contact address | since v6 accepting contact request (both from chat list and new chat sheet) opens chat and allows to send messages even if contact is offline |
| 202 | user contact address | reject request - should delete contact |
| 203 | user contact address | reject request via swipe (ios) / long press (android) |
| 204 | user contact address | "contact already exists" alert when connecting via contact request |
| 205 | user contact address | auto accept, saved on reload, disable auto accept |
| 206 | user contact address | auto accept settings (text) are offered to be saved on back or dismiss (dismiss sheet on ios / click middle pane on desktop) |
| 207 | user contact address | share with contacts dialogue on creation |
| 208 | user contact address | share with contacts toggle - confirm / cancel (reverts toggle) |
| 209 | user contact address | shared address is visible in contact info, group member info (since 5.5 - only if member has associated contact) |
| 210 | user contact address | create 1-time link via address view - if other client scans view is dismissed; if view is closed without changes (via back or dismissing sheet on ios / clicking middle pane on desktop), delete unused invitation alert is shown |
| 212 | notifications | when message arrives in another chat |
| 213 | notifications | open another chat via notification, send message from the opened chat |
| 214 | notifications | when message arrives in background |
| 215 | notifications | when contact is connected |
| 216 | notifications | when contact request is received |
| 217 | notifications | accept contact request via notification |
| 221 | settings | contact should receive profile update (display, full name, both) |
| 222 | settings | set long description in profile update (Add description, contacts updated) |
| 223 | settings | test connection with a custom server (use smp6) |
| 224 | settings | set multiple custom servers (more than one) |
| 225 | settings | test server configuration change to custom (save, reopen) |
| 226 | settings | test server configuration change from custom (alert, save, reopen) |
| 227 | settings | make command via chat console (e.g. `/v`) |
| 228 | settings | webrtc server view works |
| 229 | settings | add avatar from gallery - contacts should be updated |
| 231 | settings | remove avatar - contacts should be updated |
| 232 | settings | change app icon |
| 233 | settings | change accent color |
| 234 | settings | change theme |
| 235 | settings | enable reachable toolbar - chat list reversed (ios, android, desktop), new chat sheet (android) |
| 236 | settings | change toolbar opacity (iOS) |
| 237 | settings | change message roundness, tail |
| 238 | settings | enable/disable developer tools (enables "for console" sections in chat info views) |
| 239 | settings | developers tools enables additional fields in item info |
| 240 | settings | network - type of network connection is correctly shown (e.g. wifi, cellular) |
| 241 | settings | advanced network settings - change, save, revert, reset, should reconnect |
| 242 | settings | advanced network settings - set proxy timeouts (ios) / enable proxy (android, resets to different values) |
| 243 | settings | protect screen setting - preference on/off, hides sheets/subviews |
