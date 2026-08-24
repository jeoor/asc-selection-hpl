#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
for log in "$REPO_ROOT"/logs/HPL_N30000_NB*.log; do
  printf '%s\n' "$(basename "$log")"
  grep -E '^WR|PASSED|Elapsed \(wall clock\)' "$log"
done
