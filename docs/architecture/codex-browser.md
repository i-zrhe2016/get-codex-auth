# Architecture

`codex-browser` is a single Kasm-based container that combines the browser UI and the terminal in one runtime.

The flow is intentionally simple:

1. A user opens `https://VPS_IP:6901`.
2. Kasm Chromium provides the visible browser session.
3. The same container also exposes a terminal where `codex` is started.
4. `codex` uses the in-container Chromium session for ChatGPT OAuth.
5. The resulting `auth.json` is stored in `/home/kasm-user/.codex/auth.json`.
6. That path is bind-mounted to `./codex/` on the VPS, so the login survives container restarts.
7. When the repo lives at `/opt/codex-browser`, the durable file is `/opt/codex-browser/codex/auth.json`.

Only the credential file is treated as durable state. Chromium profile data stays ephemeral.
