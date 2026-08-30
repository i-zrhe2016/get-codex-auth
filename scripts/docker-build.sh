#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 <image:tag> [context]" >&2
  exit 1
fi

image="$1"
context="${2:-.}"

DOCKER_BUILDKIT="${DOCKER_BUILDKIT:-0}" docker build \
  -t "$image" \
  "$context"
