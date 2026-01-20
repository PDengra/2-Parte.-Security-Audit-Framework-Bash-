#!/usr/bin/env bash
# ==========================================================
# Validation helpers
# ==========================================================

require_command() {
    local cmd="$1"
    if ! command_exists "$cmd"; then
        log_warn "Required command not found: $cmd"
        return 1
    fi
    return 0
}

