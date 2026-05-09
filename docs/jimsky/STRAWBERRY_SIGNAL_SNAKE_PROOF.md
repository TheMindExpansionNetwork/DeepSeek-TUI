# Strawberry Signal Snake — DeepSeek V4 Pro Proof

## What shipped

A full-page static retro Snake arcade demo themed around cyberpunk strawberries / berry-radio energy.

- Page: `website/strawberry-snake.html`
- Linked from: `website/index.html` nav and hero CTA
- Local assets copied into: `website/assets/strawberry-snake/`
  - `shy_strawberry_big.png`
  - `neon_oracle_city_mech_1920x1080.png`
  - `strawberry_logo_dude_09_cyber_shamanic_command_deck.png`

## DeepSeek V4 Pro usage

The design pass was requested from DeepSeek V4 Pro (`deepseek-v4-pro`) using the configured `DEEPSEEK_API_KEY`. A direct OpenAI-compatible API smoke test returned HTTP 200 for `deepseek-v4-pro`. The blueprint call produced a game-design/state-machine plan including:

- Static file layout
- Title/play/pause/level-win/game-over state machine
- Keyboard, swipe, and touch controls
- Local high-score persistence
- Responsive full-page canvas
- CRT/neon styling
- Difficulty progression and hazards
- Accessibility/live-region checklist

The first `hermes chat --provider deepseek --model deepseek-v4-pro` CLI attempt timed out after 300s, so the implementation used the direct DeepSeek chat-completions API result as the model-backed design proof.

## Gameplay features

- Keyboard: Arrow keys / WASD
- Mobile: swipe gestures and on-screen direction pad
- Pause/resume: Space, P, or button
- Restart: R or button
- Local high score via `localStorage`
- Level progression with increasing signal speed
- Firewall hazards from level 3 onward
- Neon snake segments, strawberry food sprite, cyberpunk city backdrop, CRT scanlines
- No telemetry and no runtime network calls beyond same-origin local assets

## Verification performed

- Static asset existence check for referenced images
- JavaScript syntax check via `node --check` on extracted inline script
- Local static server: `python3 -m http.server 8766 --bind 127.0.0.1`
- Browser load at `http://127.0.0.1:8766/strawberry-snake.html`
- Browser interaction smoke: Start button hides overlay and game begins
- Browser vision QA confirmed full-page cyberpunk strawberry arcade layout with HUD, controls, mission feed, and playable canvas

## Notes

Raw API proof was kept out of the repo commit to avoid storing unnecessary model trace JSON. This proof file is the durable human-readable record.
