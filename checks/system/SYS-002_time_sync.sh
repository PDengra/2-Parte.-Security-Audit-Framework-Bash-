#!/usr/bin/env bash
# ==========================================================
# SYS-002 - Time synchronization enabled
# ==========================================================

CHECK_ID="SYS-002"
CHECK_NAME="System time synchronized"
CHECK_CATEGORY="System"
CHECK_SEVERITY="MEDIUM"
CHECK_PROFILES=("server" "workstation" "hardened")

run_check() {
    if command_exists timedatectl; then
        if timedatectl | grep -q "System clock synchronized: yes"; then
            check_pass "System time is synchronized"
        else
            check_fail \
                "Time synchronization disabled" \
                "Enable NTP using systemd-timesyncd or chrony"
        fi
    else
        check_warn \
            "timedatectl not available" \
            "Verify time synchronization manually"
    fi
}

