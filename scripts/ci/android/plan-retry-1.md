## Cases

| Row | Section | Case |
|---|---|---|
| 8 | create profile -> welcome page, onboarding | logo color changes in dark mode |
| 15 | create profile -> welcome page, onboarding | if app is opened via SimpleX link and profile doesn't exist, profile has to be created first |
| 23 | create profile -> welcome page, onboarding | lock - shows notice on next (ios - on 2nd) chat start, turn on (since 5.0 - can choose system / passcode) (3+ contacts) |
| 25 | create profile -> welcome page, onboarding | reachable toolbar card can be toggled, dismissed |
| 26 | create profile -> welcome page, onboarding | "create address" card - create address / open "how to use it"; create address from "how to use it" / create 1-time link (delete address and reset hints in developer tools to test different scenarios) |
| 34 | add / accept contact, send messages | join via link / open on mobile button when profile is not created yet |
| 35 | add / accept contact, send messages | join by pasting link |
| 59 | add / accept contact, send messages | contact aborts connection switch |
| 71 | short links data | scanning business chat link shows open chat alert, open, connect, send messages |
| 72 | short links data | connecting to business chat opened via link with network off shows spinner, then offers to retry; retry |
| 96 | post-quantum encryption | allow PQ encryption for contact without PQ via chat info on both sides - should upgrade after a few messages |
| 115 | sending message replies, reactions | reply to emoji (quote font is small), reply with emoji (large font) |
| 118 | sending message replies, reactions | react with same reaction (by tapping on other's reaction) |
| 121 | private notes | create message, edit message, delete message |
| 122 | private notes | create file / image / video, view, save |
| 123 | private notes | clear notes |
| 125 | editing and deletion | can edit today's sent message, the recipient is updated (direct/group) - shows edited icon |
| 127 | editing and deletion | can edit the message that was deleted on the recipient side, it arrives as new |
| 128 | editing and deletion | edit markdown |
| 129 | editing and deletion | edit without change - no error, no update |
| 130 | editing and deletion | can delete messages locally - mine, sender's in direct/group chats |
| 131 | editing and deletion | can delete message for all - direct/group, recipients see "deleted", can be revealed |
| 132 | editing and deletion | can delete message that was deleted by sender |
| 133 | editing and deletion | group moderation - can delete other member's message as admin |
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
