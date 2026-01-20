#!/usr/bin/env bash
# ==========================================================
# Output handling
# ==========================================================

declare -a CHECK_RESULTS=()

init_output() {
    START_TIME="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}

check_pass() {
    record_result "PASS" "$1" ""
}

check_warn() {
    record_result "WARN" "$1" "$2"
}

check_fail() {
    record_result "FAIL" "$1" "$2"
}

record_result() {
    local status="$1"
    local evidence="$2"
    local recommendation="$3"

    CHECK_RESULTS+=("{
        \"id\": \"${CHECK_ID}\",
        \"name\": \"${CHECK_NAME}\",
        \"category\": \"${CHECK_CATEGORY}\",
        \"severity\": \"${CHECK_SEVERITY}\",
        \"status\": \"${status}\",
        \"evidence\": \"${evidence}\",
        \"recommendation\": \"${recommendation}\"
    }")
}

write_report() {
    local report_file="${REPORTS_DIR}/audit-$(date +%Y%m%d%H%M%S).json"

    {
        echo "{"
        echo "  \"metadata\": {"
        echo "    \"tool\": \"security-audit\","
        echo "    \"version\": \"${FRAMEWORK_VERSION}\","
        echo "    \"timestamp\": \"${START_TIME}\""
        echo "  },"
        echo "  \"system\": {"
        echo "    \"hostname\": \"${HOSTNAME}\","
        echo "    \"os\": \"${OS_NAME}\","
        echo "    \"kernel\": \"${KERNEL_VERSION}\","
        echo "    \"virtualized\": ${VIRTUALIZED}"
        echo "  },"
        echo "  \"summary\": $(summary_json),"
        echo "  \"results\": ["
        printf "%s\n" "$(join_by , "${CHECK_RESULTS[@]}")"
        echo "  ]"
        echo "}"
    } > "$report_file"

    log_info "Report written to ${report_file}"
}

