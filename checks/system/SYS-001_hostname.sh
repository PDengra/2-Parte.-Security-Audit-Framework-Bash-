#!/usr/bin/env bash
# ==========================================================
# SYS-001 - Hostname properly configured
# ==========================================================

CHECK_ID="SYS-001"
CHECK_NAME="System hostname properly configured"
CHECK_CATEGORY="System"
CHECK_SEVERITY="LOW"
CHECK_PROFILES=("server" "workstation" "hardened")

run_check() {
    local hostname
    hostname="$(hostname)"

    if [[ -z "$hostname" ]]; then
        check_fail \
            "Hostname is empty" \
            "Configure a valid hostname using hostnamectl"
        return
    fi

    case "$hostname" in
        localhost|localhost.localdomain)
            check_fail \
                "Hostname is set to ${hostname}" \
                "Set a unique hostname using hostnamectl"
            ;;
        *)
            check_pass "Hostname configured: ${hostname}"
            ;;
    esac
}

