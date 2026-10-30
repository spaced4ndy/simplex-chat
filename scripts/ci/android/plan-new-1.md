## Cases

| Row | Section | Case |
|---|---|---|
| 188 | chat view | Appearance -> Chat layout: Terminal - chats shown without bubbles, sender name once per series, time at line end |
| 189 | chat view | chat layout set per profile and per chat (chat theme) overrides app setting; switch back to Classic |
| 190 | chat view | terminal layout - quotes, images, files, voice messages, markdown blocks displayed correctly |
| 191 | chat view | CLI: create address (`/ad`), set terminal layout for it (`/_address_settings 1 {"businessAddress":false,"autoAccept":{"acceptIncognito":false},"chatLayout":"terminal"}`), show it (`/sa`); app connects via this address - chat with CLI opens in terminal layout |
| 253 | settings | developer options -> Storage shows app storage breakdown (android, desktop); ios: Delete temp data enabled only when chat is stopped |
| 315 | markdown | headings, lists, quotes, code blocks, tables, rules are rendered in messages |
| 316 | markdown | **text** is bold |
| 317 | markdown | link in parentheses is a link: "(see https://simplex.chat)" - link without the brackets |
| 318 | markdown | single line breaks are kept in messages with lists/quotes/headings: "# Title", new line, "line one", new line, "line two" - "line one" and "line two" shown on separate lines |
| 319 | markdown | phone starting with "+" or "0" is a link; numbers, dates, IP addresses, versions and "#42" stay text: "07777 777 777" and "+44 7777 777 777" are phone links; "12345678", "2024-10-29", "192.168.1.1", "7.1.0.14", "issue #42" stay plain text |
| 320 | markdown | receive .md file, tap - opens in Formatted view, can switch to Text view |
| 321 | markdown | link with unicode characters in address - shown as unicode markers: "https://simplеx.chat" typed with Cyrillic "е" - shown as "https://simpl[U+0435]x.chat" in message and in open link alert |
