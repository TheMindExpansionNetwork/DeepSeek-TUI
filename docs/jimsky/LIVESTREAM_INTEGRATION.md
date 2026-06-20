# Livestream Integration Plan — DeepSeek TUI as a Safe Agent Lane

## Goal

Use DeepSeek TUI as a visible but safe “agent brain” lane during a live build stream: it can produce code-review notes, status cards, and planning output while the stream shows sanitized progress, not secrets or uncontrolled shell access.

## Safe architecture

```text
Hermes / operator prompt
        |
        v
scripts/jimsky-deepseek-safe.sh exec ...
        |
        v
sanitized stdout / status JSON / curated card
        |
        v
Program Deck / OBS browser source / fake terminal overlay
```

## What to show live

- Short status cards: current task, model, mode, safe next step.
- Diffs after human review, not raw unrestricted terminal history.
- `deepseek doctor --json` safe subset: version, sandbox availability, workspace, model/provider, no keys.
- Agent response excerpts after a sanitizer pass.

## What not to show live

- `/opt/data/.env`, stream keys, API keys, tokens, private DMs, GitHub credentials.
- Raw terminal windows where secrets may scroll by.
- Public chat directly triggering `deepseek exec`, shell commands, pushes, uploads, payments, or deploys.

## First stream demo prompt

```text
You are the DeepSeek TUI livestream build reviewer. Inspect the current repo state and return a 5-bullet safe status card for viewers. Do not edit files, do not run network commands, and do not print secrets.
```

## Status JSON bridge

The stream-safe JSON bridge writes a sanitized status card for Program Deck / OBS browser overlays:

```bash
cd /opt/data/workspace/projects/DeepSeek-TUI
scripts/jimsky-deepseek-status-json.sh
cat /opt/data/run/deepseek_tui_live_status.json
```

Default output path: `/opt/data/run/deepseek_tui_live_status.json`.

## Upgrade path

1. Keep this as a Hermes-launched external agent lane using `deepseek exec`.
2. Use `scripts/jimsky-deepseek-status-json.sh` as the sanitizer/status JSON bridge for Program Deck.
3. Optionally run `deepseek serve --http --host 127.0.0.1 --port 7878 --auth-token $DEEPSEEK_RUNTIME_TOKEN` for a localhost-only API bridge.
4. If used on stream, require a runtime token and bind only to `127.0.0.1`; never expose the runtime API publicly.
