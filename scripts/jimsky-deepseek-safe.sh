#!/usr/bin/env bash
set -euo pipefail

DEEPSEEK_BIN="${DEEPSEEK_BIN:-/opt/data/workspace/tools/deepseek-tui/node_modules/.bin/deepseek}"
if [ ! -x "$DEEPSEEK_BIN" ]; then
  echo "DeepSeek TUI binary not found at $DEEPSEEK_BIN" >&2
  echo "Install with: npm install --prefix /opt/data/workspace/tools/deepseek-tui deepseek-tui@latest" >&2
  exit 127
fi

# Load local protected env if present. Never echo secrets.
set -a
[ -f /opt/data/.env ] && . /opt/data/.env
set +a

export DEEPSEEK_APPROVAL_POLICY="${DEEPSEEK_APPROVAL_POLICY:-on-request}"
export DEEPSEEK_SANDBOX_MODE="${DEEPSEEK_SANDBOX_MODE:-workspace-write}"
export DEEPSEEK_MODEL="${DEEPSEEK_MODEL:-deepseek-v4-flash}"

cd "${DEEPSEEK_WORKSPACE:-$(pwd)}"

exec "$DEEPSEEK_BIN" \
  --model "$DEEPSEEK_MODEL" \
  --approval-policy "$DEEPSEEK_APPROVAL_POLICY" \
  --sandbox-mode "$DEEPSEEK_SANDBOX_MODE" \
  "$@"
