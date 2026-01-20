#!/usr/bin/env bash
# ==========================================================
# Bootstrap: framework initialization
# ==========================================================

FRAMEWORK_VERSION="2.0.0"

# ---------- Error handling ----------
trap 'on_error ${LINENO}' ERR

on_error() {
    local line="$1"
    log_error "Unexpected error at line ${line}"
    exit 1
}

# ---------- Global paths ----------
export BASE_DIR
export CONF_DIR="${BASE_DIR}/conf"
export CORE_DIR="${BASE_DIR}/core"
export LIB_DIR="${BASE_DIR}/lib"
export CHECKS_DIR="${BASE_DIR}/checks"
export PROFILES_DIR="${BASE_DIR}/profiles"
export REPORTS_DIR="${BASE_DIR}/reports"

# ---------- Load libraries ----------
source "${LIB_DIR}/logging.sh"
source "${LIB_DIR}/utils.sh"
source "${LIB_DIR}/validation.sh"
source "${LIB_DIR}/colors.sh"

source "${CORE_DIR}/environment.sh"
source "${CORE_DIR}/dispatcher.sh"
source "${CORE_DIR}/output.sh"
source "${CORE_DIR}/scoring.sh"

# ---------- Defaults ----------
PROFILE="auto"
ONLY_CATEGORIES=()
EXCLUDE_CATEGORIES=()
JSON_ONLY=false
DRY_RUN=false

# ---------- Argument parsing ----------
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --profile)
                PROFILE="$2"
                shift 2
                ;;
            --only)
                IFS=',' read -ra ONLY_CATEGORIES <<< "$2"
                shift 2
                ;;
            --exclude)
                IFS=',' read -ra EXCLUDE_CATEGORIES <<< "$2"
                shift 2
                ;;
            --json-only)
                JSON_ONLY=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --list-checks)
                list_checks
                exit 0
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
}

# ---------- Framework init ----------
init_framework() {
    mkdir -p "${REPORTS_DIR}"

    init_logging
    detect_environment
    load_profile "${PROFILE}"

    require_root
    init_output

    log_info "Security Audit Framework v${FRAMEWORK_VERSION} initialized"
}

run_audit() {
    dispatch_checks
}

finalize_output() {
    generate_score
    write_report
}

