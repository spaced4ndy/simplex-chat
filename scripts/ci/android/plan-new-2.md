## Cases

| Row | Section | Case |
|---|---|---|
| 362 | files | tap file while it is being received - opens when received |
| 363 | files | android: with keyboard open, attachment options (camera, image, video, file) appear above keyboard |
| 490 | groups | auto-accept group invitations (Privacy & security -> Auto-accept -> Group invitations), per profile - joined automatically |
| 491 | groups | invitation to another group sent to group member (CLI) - shown as "For you only", can be accepted: CLI creates groups g1 (direct messages allowed) and g2, app user joins g1; in CLI `/i #g1 <app user>` (g1 group ID, member ID), `/i #g2` (g2 group ID), `/_add #<g2 ID> #<g1 ID> <member ID> member` - app gets invitation to g2 in g1 marked "For you only", accepts, joins g2 |
| 513 | channels | owner makes subscriber moderator - member info shows Moderator; moderator sees subscribers list |
| 514 | channels | moderator deletes message for all - deleted for all subscribers |
| 515 | channels | owner turns on Sign messages (channel preferences) - confirmation alert; new messages show signature mark, item info shows "Signed & verified" |
| 516 | channels | subscriber who joins after signing is turned on sees "signature missing" on earlier messages, tap shows alert |
| 700 | supporter badges | Support SimpleX opens from chat list banner and from settings; "How badges protect your privacy" opens |
| 701 | supporter badges | chat list banner - close button appears only after banner was opened |
| 703 | supporter badges | redeem wrong code / already used code - clear error, not generic failure |
