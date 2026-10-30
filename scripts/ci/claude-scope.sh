#!/bin/bash

# Reads what an app workflow's Claude job runs from its claude-scope, as the plan job's outputs: backend (yes or no),
# sessions (a JSON list of the sessions, each run as its own job: ["main"] when the scope lists none) and parallel (how
# many session jobs run at once: 1 unless the scope says). Fails when the scope is malformed, or when its sessions use
# the test backend and the run doesn't start it.
# Usage: scripts/ci/claude-scope.sh <claude-scope> <true when the run starts the test backend>

set -euo pipefail

file=$1
backend_started=$2

scope() {
  sed -n "s/^$1: *//p" "$file"
}

backend=$(scope backend)
case "$backend" in
  yes | no) ;;
  *)
    echo "::error::claude-scope must say backend: yes or backend: no"
    exit 1
    ;;
esac
if [ "$backend" = yes ] && [ "$backend_started" != true ]; then
  echo "::error::claude-scope says the Claude sessions use the test backend: ask for it too"
  exit 1
fi
sessions=$(scope sessions)
for session in ${sessions:=main}; do
  if ! [[ "$session" =~ ^[a-z0-9-]+$ ]]; then
    echo "::error::claude-scope's session \"$session\" must be named with lowercase letters, digits and -"
    exit 1
  fi
done
parallel=$(scope parallel)
if ! [[ "${parallel:=1}" =~ ^[1-9][0-9]*$ ]]; then
  echo "::error::claude-scope's parallel must be a number of jobs"
  exit 1
fi
{
  echo "backend=$backend"
  echo "sessions=$(jq -cn --arg s "$sessions" '$s | split(" ") | map(select(. != ""))')"
  echo "parallel=$parallel"
} | tee -a "$GITHUB_OUTPUT"
