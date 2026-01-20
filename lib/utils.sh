#!/usr/bin/env bash
# ==========================================================
# Utility functions
# ==========================================================

require_root() {
    if [[ "$(id -u)" -ne 0 ]]; then
        log_error "This audit must be run as root"
        exit 1
    fi
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

join_by() {
    local IFS="$1"
    shift
    echo "$*"
}

