#!/usr/bin/env bash
# ==========================================================
# SRV-003 - Enabled services review
# ==========================================================

CHECK_ID="SRV-003"
CHECK_NAME="Review enabled services at boot"
CHECK_CATEGORY="Services"
CHECK_SEVERITY="LOW"
CHECK_PROFILES=("server" "hardened")

run_check() {
    if ! command_exists systemctl; then
        check_warn \
            "systemctl not available" \
            "Review enabled services manually"
        return
    fi

    local services
    services=$(systemctl list-unit-files --type=service --state=enabled 2>/dev/null | wc -l)

    if [[ "$services" -le 20 ]]; then
        check_pass "Limited number of enabled services (${services})"
    else
        check_warn \
            "Many enabled services (${services})" \
            "Review enabled services and disable unnecessary ones"
    fi
}
