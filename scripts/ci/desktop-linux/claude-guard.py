#!/usr/bin/env python3

# PreToolUse hook for Claude on the runner: lets through only Bash commands that run the ui, peer or record helper,
# with plain arguments, so the session has no general shell. Claude Code runs read-only commands such as cat and echo
# without asking in every permission mode, so permission rules alone can't exclude them.
# Exits 2 for anything else; Claude sees the message as the reason. Each decision is appended to CLAUDE_GUARD_LOG
# when it is set, as evidence that the hook ran.

import json
import os
import re
import sys

# nothing that substitutes, expands with $ or escapes
HELPER_COMMAND = re.compile(r"(ui|peer|record)( [^$`\\\r\n]*)?")
# and, outside quotes, nothing that chains, pipes, redirects or starts a subshell, and no glob, brace or tilde
# expansion, which could turn names of files the session creates into arguments; QUOTED finds the shell's quotes
# only because HELPER_COMMAND refuses backslashes
UNQUOTED_SPECIAL = re.compile(r"[;&|<>()*?\[\]{}~]")
QUOTED = re.compile(r"\"[^\"]*\"|'[^']*'")

call = json.load(sys.stdin)
command = (call.get("tool_input") or {}).get("command", "").strip()
allowed = call.get("tool_name") != "Bash" or (
    HELPER_COMMAND.fullmatch(command) and not UNQUOTED_SPECIAL.search(QUOTED.sub("", command))
)
if os.environ.get("CLAUDE_GUARD_LOG"):
    with open(os.environ["CLAUDE_GUARD_LOG"], "a") as log:
        log.write(f"{'allow' if allowed else 'refuse'} {call.get('tool_name')}: {command[:200]!r}\n")
if not allowed:
    print(
        f"Only the ui, peer and record helpers run here, as one command: ui <command> [args]. Refused: {command[:200]}",
        file=sys.stderr,
    )
    sys.exit(2)
