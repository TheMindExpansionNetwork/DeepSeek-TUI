#!/usr/bin/env bash
set -euo pipefail

OUT="${DEEPSEEK_STATUS_JSON:-/opt/data/run/deepseek_tui_live_status.json}"
WORKSPACE="${DEEPSEEK_WORKSPACE:-/opt/data/workspace/projects/DeepSeek-TUI}"
PROMPT=${1:-'Return a concise, stream-safe status card for viewers in 4 bullets. Do not edit files, do not run commands, and do not print secrets.'}
mkdir -p "$(dirname "$OUT")"
cd "$WORKSPACE"

started_at=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
set +e
text=$(./scripts/jimsky-deepseek-live-status.sh "$PROMPT" 2>&1)
code=$?
set -e
# Redact common secret patterns one more time before JSON writing.
text=$(printf '%s' "$text" | sed -E 's/sk-[A-Za-z0-9_-]+/[REDACTED]/g; s/(api[_-]?key|token|secret)([^[:space:]]*)/[REDACTED]/Ig')
tmp=$(mktemp)
printf '%s' "$text" > "$tmp"
python3 - "$OUT" "$started_at" "$code" "$tmp" <<'PY'
import datetime, json, sys
out, started_at, code, text_path = sys.argv[1], sys.argv[2], int(sys.argv[3]), sys.argv[4]
text = open(text_path, encoding='utf-8', errors='replace').read().strip()
obj = {
    "source": "deepseek-tui",
    "mode": "safe-status-card",
    "started_at": started_at,
    "updated_at": datetime.datetime.now(datetime.timezone.utc).isoformat().replace('+00:00','Z'),
    "ok": code == 0,
    "exit_code": code,
    "text": text[-4000:],
}
open(out, 'w', encoding='utf-8').write(json.dumps(obj, indent=2, ensure_ascii=False) + "\n")
print(out)
PY
rm -f "$tmp"
exit "$code"
