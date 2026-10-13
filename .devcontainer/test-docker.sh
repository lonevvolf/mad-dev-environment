#!/usr/bin/env bash
set -euo pipefail

# Run inside the rebuilt devcontainer, as the normal development user.
docker version
docker info
docker compose version
docker buildx version

image="mad-docker-smoke:$(date +%s)-$$"
trap 'docker image rm "$image" >/dev/null 2>&1 || true' EXIT

docker build --tag "$image" - <<'DOCKERFILE'
FROM alpine:3.22
CMD ["sh", "-c", "printf 'MAD Docker smoke test passed\\n'"]
DOCKERFILE

output="$(docker run --rm "$image")"
test "$output" = "MAD Docker smoke test passed"
printf '%s\n' "$output"
