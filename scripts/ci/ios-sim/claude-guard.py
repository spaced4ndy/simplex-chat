#!/usr/bin/env python3

# PreToolUse hook for Claude on the runner: lets through only Bash commands that run the ui, peer or record helper,
# with plain arguments, so the session has no general shell. Claude Code runs read-only commands such as cat, echo and env without
# asking in every permission mode, and Bash inherits CLAUDE_CODE_OAUTH_TOKEN, so permission rules alone are not enough.
# Exits 2 for anything else; Claude sees the message as the reason. Each decision is appended to CLAUDE_GUARD_LOG
# when it is set, as evidence that the hook ran.

import json
import os
import re
import sys

HELPER_COMMAND = re.compile(r"(ui|peer|record)( .*)?", re.DOTALL)
# no escapes or line breaks anywhere, so the quotes are found by reading left to right; outside quotes nothing that
# chains, pipes, redirects, starts a subshell, substitutes, or expands globs, braces or tildes, which could turn names
# of files the session creates into arguments; inside double quotes no substitution
REFUSED_ANYWHERE = set("\\\r\n")
REFUSED_UNQUOTED = set(";&|<>()*?[]{}~$`")
REFUSED_DOUBLE_QUOTED = set("$`")


def plain_arguments(command):
    quote = None
    for c in command:
        if c in REFUSED_ANYWHERE:
            return False
        if quote is None:
            if c in REFUSED_UNQUOTED:
                return False
            if c in "'\"":
                quote = c
        elif c == quote:
            quote = None
        elif quote == '"' and c in REFUSED_DOUBLE_QUOTED:
            return False
    return quote is None


call = json.load(sys.stdin)
command = (call.get("tool_input") or {}).get("command", "").strip()
allowed = call.get("tool_name") != "Bash" or (HELPER_COMMAND.fullmatch(command) and plain_arguments(command))
if os.environ.get("CLAUDE_GUARD_LOG"):
    with open(os.environ["CLAUDE_GUARD_LOG"], "a") as log:
        log.write(f"{'allow' if allowed else 'refuse'} {call.get('tool_name')}: {command[:200]!r}\n")
if not allowed:
    print(
        f"Only the ui, peer and record helpers run here, as one command: ui <command> [args]. Refused: {command[:200]}",
        file=sys.stderr,
    )
    sys.exit(2)
