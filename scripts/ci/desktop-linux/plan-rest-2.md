## Cases

| Row | Section | Case |
|---|---|---|
| 119 | sending message replies, reactions | long press reaction in group chat to view list of reacted members, navigate to member info via this list (not yet implemented) |
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
| 183 | chat view | in 6.2 - only android/desktop: chat is opened on first unread message |
| 184 | chat view | in 6.2 - only android/desktop: navigate via quote to message that is not loaded (e.g. quoted message is higher than last 100+ messages and chat is opened on last message after all read) |
| 185 | chat view | content filter - media, links, etc. |
| 186 | chat view | navigate to message filtered via content filter |
| 187 | chat view | select text in message (Desktop) |
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
