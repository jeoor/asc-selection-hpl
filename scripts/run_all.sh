#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HPL_BIN="${HPL_BIN:-/root/autodl-tmp/ASC_SELECTION/hpl-2.3/bin/a800_ch3/xhpl}"
MPIEXEC="${MPIEXEC:-/root/autodl-tmp/ASC_SELECTION/mpich-ch3/bin/mpiexec}"
MPI_RANKS="${MPI_RANKS:-14}"

export OPENBLAS_NUM_THREADS=1
export OMP_NUM_THREADS=1

for config in "$REPO_ROOT"/configs/HPL_N30000_NB*.dat; do
  label="$(basename "$config" .dat)"
  run_dir="$REPO_ROOT/results/runs/$label"
  mkdir -p "$run_dir"
  cp "$config" "$run_dir/HPL.dat"
  (
    cd "$run_dir"
    /usr/bin/time -v "$MPIEXEC" -n "$MPI_RANKS" "$HPL_BIN"
  ) 2>&1 | tee "$REPO_ROOT/logs/$label.log"
done
