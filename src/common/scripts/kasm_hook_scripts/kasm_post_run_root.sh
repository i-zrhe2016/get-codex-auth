#!/usr/bin/env bash
set -euo pipefail

codex_dir="/home/kasm-user/.codex"

mkdir -p "$codex_dir"
chown -R 1000:0 "$codex_dir"
chmod 700 "$codex_dir"

if [ -f "$codex_dir/auth.json" ]; then
  chown 1000:0 "$codex_dir/auth.json"
  chmod 600 "$codex_dir/auth.json"
fi
