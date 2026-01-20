#!/usr/bin/env bash
# ==========================================================
# Security Audit Framework
# Entry point
# ==========================================================

set -Eeuo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Cargar bootstrap (manejo de errores, logging, entorno)
source "${BASE_DIR}/core/bootstrap.sh"

usage() {
    cat <<EOF
Usage: audit.sh [options]

Options:
  --profile <name>        Profile to use (server, workstation, hardened, auto)
  --list-checks           List available checks
  --only <CAT1,CAT2>      Run only selected categories
  --exclude <CAT1,CAT2>   Exclude categories
  --json-only             Disable console output
  --dry-run               Show what would be executed
  -h, --help              Show this help
EOF
}

parse_args "$@"

init_framework
run_audit
finalize_output

