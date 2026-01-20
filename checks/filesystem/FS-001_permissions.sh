#!/usr/bin/env bash
# ==========================================================
# FS-001 - /etc/shadow permissions
# ==========================================================

CHECK_ID="FS-001"
CHECK_NAME="/etc/shadow permissions properly configured"
CHECK_CATEGORY="Filesystem"
CHECK_SEVERITY="CRITICAL"
CHECK_PROFILES=("server" "workstation" "hardened")

run_check() {
    local perms owner group

    if [[ ! -f /etc/shadow ]]; then
        check_fail \
            "/etc/shadow file not found" \
            "Verify system integrity"
        return
    fi

    perms=$(stat -c "%a" /etc/shadow)
    owner=$(stat -c "%U" /etc/shadow)
    group=$(stat -c "%G" /etc/shadow)

    if [[ "$perms" -le 640 && "$owner" == "root" && "$group" == "shadow" ]]; then
        check_pass "/etc/shadow permissions are secure (${owner}:${group} ${perms})"
    else
        check_fail \
            "Permissions: ${owner}:${group} ${perms}" \
            "Set owner to root:shadow and permissions to 640 or stricter"
    fi
}
