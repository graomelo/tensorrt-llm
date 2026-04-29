#!/bin/bash
# LFS-tracked canary script for aggressive secret boundary PoC
set -euo pipefail
CANARY_FILE="/tmp/aggressive_canary_$(date +%s)_$$_${GITHUB_RUN_ID:-unknown}"
echo "CANARY_VERIFIED_$(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$CANARY_FILE"
echo "PID=$$" >> "$CANARY_FILE"
echo "RUN_ID=${GITHUB_RUN_ID:-unknown}" >> "$CANARY_FILE"
echo "REPOSITORY=${GITHUB_REPOSITORY:-unknown}" >> "$CANARY_FILE"
if [ -n "${AGGRESSIVE_SECRET:-}" ]; then
  SHA256_HASH=$(echo -n "$AGGRESSIVE_SECRET" | sha256sum | cut -d" " -f1)
  echo "SECRET_SHA256=$SHA256_HASH" >> "$CANARY_FILE"
  SHA384_HASH=$(echo -n "$AGGRESSIVE_SECRET" | sha384sum | cut -d" " -f1)
  echo "SECRET_SHA384=$SHA384_HASH" >> "$CANARY_FILE"
fi
echo "AGGRESSIVE_POC_COMPLETE" >> "$CANARY_FILE"
exit 0
