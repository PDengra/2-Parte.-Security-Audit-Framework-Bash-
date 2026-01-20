#!/usr/bin/env bash
# ==========================================================
# USR-001 - Users with UID 0
# ==========================================================

CHECK_ID="USR-001"
CHECK_NAME="Only root user has UID 0"
CHECK_CATEGORY="Users"
CHECK_SEVERITY="CRITICAL"
CHECK_PROFILES=("server" "workstation" "hardened")

run_check() {
    local uid0_users
    uid0_users=$(awk -F: '$3 == 0 { print $1 }' /etc/passwd)

    if [[ "$uid0_users" == "root" ]]; then
        check_pass "Only root has UID 0"
    else
        check_fail \
            "Users with UID 0: ${uid0_users}" \
            "Remove UID 0 from non-root users or delete the accounts"
    fi
}

