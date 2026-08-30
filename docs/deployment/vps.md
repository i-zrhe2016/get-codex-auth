# VPS Deployment

## Build

```bash
./scripts/docker-build.sh codex-browser:local .
```

## Run

```bash
docker compose up -d
```

The container publishes Kasm on port `6901`.

## First Login

1. Open `https://VPS_IP:6901`.
2. Accept the browser certificate warning if the Kasm image uses a self-signed cert.
3. Open a terminal in the Kasm desktop.
4. Run `codex`.
5. Choose `Sign in with ChatGPT`.
6. Complete the OAuth flow in the same container's Chromium window.

## Persistence

- The host bind mount is `./codex/`.
- When the repo is deployed at `/opt/codex-browser`, the durable file is `/opt/codex-browser/codex/auth.json`.
- The durable file is `./codex/auth.json`.
- The root Kasm hook creates the directory and fixes permissions on startup.

## Notes

- Change `VNC_PW` before exposing the service beyond a trusted network.
- If you remove the container but keep `./codex/`, the login state remains.
