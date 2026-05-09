# Jimsky Fork Strategy — DeepSeek TUI

## Repos

- Jimsky fork: <https://github.com/TheMindExpansionNetwork/DeepSeek-TUI>
- Upstream source: <https://github.com/Hmbown/DeepSeek-TUI>
- Local workbench: `/opt/data/workspace/projects/DeepSeek-TUI`

## License / attribution

The upstream project is MIT-licensed in `LICENSE` and `Cargo.toml`. Keep the MIT license and upstream attribution intact in all copies, public demos, packages, and stream overlays that mention this tool.

## Branch model

- `main`: kept close to `upstream/main` for easy updates.
- `jimsky/agent-stream-setup`: Jimsky setup/runbook layer for safe local agent and livestream use.
- `vendor-sync/*`: temporary branches for upstream sync/merge work.
- Future product-specific changes should use `jimsky/*` branches and avoid cluttering `main` unless a change is meant to be upstream-compatible.

## Safe sync

```bash
cd /opt/data/workspace/projects/DeepSeek-TUI
git fetch upstream --prune
git checkout main
git pull --ff-only origin main
git checkout -b vendor-sync/upstream-$(date -u +%Y%m%d)
git merge upstream/main
# resolve/test, then PR or fast-forward as appropriate
```

Never push to `upstream`; this clone sets the upstream push URL to `DISABLED`.

## Agent safety notes

- Do not commit `.env`, provider keys, stream keys, tokens, SSH keys, private deployment data, generated media batches, or model weights.
- Use Plan/Agent modes for livestream work; avoid YOLO on-stream.
- For public stream display, show sanitized outputs/status cards rather than raw unrestricted terminals.
- Keep chat/community input as a moderated queue. Do not connect public chat directly to shell commands, payments, posts, uploads, repo pushes, or destructive actions.
