#!/usr/bin/env bash
# ==========================================================
# Scoring and compliance
# ==========================================================

generate_score() {
    PASS_COUNT=0
    FAIL_COUNT=0
    WARN_COUNT=0

    for r in "${CHECK_RESULTS[@]}"; do
        case "$r" in
            *\"status\":\ \"PASS\"*) ((PASS_COUNT++)) ;;
            *\"status\":\ \"FAIL\"*) ((FAIL_COUNT++)) ;;
            *\"status\":\ \"WARN\"*) ((WARN_COUNT++)) ;;
        esac
    done

    TOTAL=$((PASS_COUNT + FAIL_COUNT + WARN_COUNT))
    SCORE=$(( TOTAL > 0 ? (PASS_COUNT * 100) / TOTAL : 0 ))

    if (( SCORE >= 85 )); then
        COMPLIANCE="COMPLIANT"
    elif (( SCORE >= 60 )); then
        COMPLIANCE="PARTIALLY_COMPLIANT"
    else
        COMPLIANCE="NON_COMPLIANT"
    fi
}

summary_json() {
    cat <<EOF
{
  "pass": ${PASS_COUNT},
  "fail": ${FAIL_COUNT},
  "warn": ${WARN_COUNT},
  "score": ${SCORE},
  "compliance": "${COMPLIANCE}"
}
EOF
}

