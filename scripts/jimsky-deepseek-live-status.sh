#!/usr/bin/env bash
set -euo pipefail
cd "${DEEPSEEK_WORKSPACE:-/opt/data/workspace/projects/DeepSeek-TUI}"
PROMPT=${1:-'Return a concise 5-bullet safe livestream status card for this DeepSeek TUI fork. Do not edit files and do not print secrets.'}
./scripts/jimsky-deepseek-safe.sh exec "$PROMPT" \
  2>&1 | sed -E 's/sk-[A-Za-z0-9_-]+/[REDACTED]/g; s/(api[_-]?key|token|secret)([^[:space:]]*)/[REDACTED]/Ig'
