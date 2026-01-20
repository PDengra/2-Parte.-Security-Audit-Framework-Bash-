#!/usr/bin/env bash
# ==========================================================
# Logging library
# ==========================================================

LOG_LEVEL_INFO=1
LOG_LEVEL_WARN=2
LOG_LEVEL_ERROR=3

CURRENT_LOG_LEVEL=$LOG_LEVEL_INFO

init_logging() {
    : "${JSON_ONLY:=false}"
}

_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

_log() {
    local level="$1"
    local label="$2"
    local message="$3"

    [[ "$JSON_ONLY" == true ]] && return 0

    printf "[%s] [%s] %s\n" "$(_timestamp)" "$label" "$message"
}

log_info() {
    _log "$LOG_LEVEL_INFO" "INFO" "$1"
}

log_warn() {
    _log "$LOG_LEVEL_WARN" "WARN" "$1"
}

log_error() {
    _log "$LOG_LEVEL_ERROR" "ERROR" "$1" >&2
}

