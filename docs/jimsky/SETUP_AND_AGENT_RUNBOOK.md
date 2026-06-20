# Jimsky Setup & Agent Runbook — DeepSeek TUI

## Current local install

This machine has a local npm-prefix install of the released DeepSeek TUI wrapper:

```bash
/opt/data/workspace/tools/deepseek-tui/node_modules/.bin/deepseek --version
```

Why local-prefix: it avoids mutating the system global npm install and gives Hermes a stable absolute command path.

## Credential posture

- The repo must not contain API keys.
- This machine can load `DEEPSEEK_API_KEY` from `/opt/data/.env` at runtime.
- Verify credential source without printing secrets:

```bash
set -a; [ -f /opt/data/.env ] && . /opt/data/.env; set +a
/opt/data/workspace/tools/deepseek-tui/node_modules/.bin/deepseek auth status
```

`auth status` prints only the source/last4; do not copy full keys into chat, docs, overlays, or stream scenes.

## Hermes-callable command

For a bounded second-opinion/code-agent call from Hermes or a shell:

```bash
cd /opt/data/workspace/projects/DeepSeek-TUI
set -a; [ -f /opt/data/.env ] && . /opt/data/.env; set +a
/opt/data/workspace/tools/deepseek-tui/node_modules/.bin/deepseek \
  --model deepseek-v4-flash \
  --approval-policy on-request \
  --sandbox-mode workspace-write \
  exec 'Inspect the repo and summarize the next safe improvement. Do not edit files.'
```

For interactive terminal use:

```bash
scripts/jimsky-deepseek-safe.sh
```

For a one-shot noninteractive prompt:

```bash
scripts/jimsky-deepseek-safe.sh exec 'Reply with a concise status card for the livestream.'
```

For a Program Deck / OBS-readable JSON status file:

```bash
scripts/jimsky-deepseek-status-json.sh
cat /opt/data/run/deepseek_tui_live_status.json
```

## Recommended defaults

- Normal work: `--approval-policy on-request --sandbox-mode workspace-write`
- Model for cheap/status turns: `deepseek-v4-flash`
- Model for heavy code review: `deepseek-v4-pro`
- Avoid public-stream YOLO. YOLO removes the approval rhythm and is not appropriate for chat-influenced demos.

## Verified smoke checks

Performed on this machine:

```text
binary: deepseek npm wrapper v0.8.24 / binary v0.8.24
credential source: env
sandbox: linux-landlock available
test: deepseek --model deepseek-v4-flash ... exec 'Reply exactly ...'
result: DEEPSEEK_TUI_SMOKE_OK
```

Rust source check was run after installing Rust 1.88.0 on this machine:

```bash
. "$HOME/.cargo/env"
rustc --version
cargo check --workspace --locked
```
