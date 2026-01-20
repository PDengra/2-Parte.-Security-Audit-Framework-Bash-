#!/usr/bin/env bash
# colors.sh – Definición de colores y estilos para salida en consola

if [[ "${ENABLE_COLOR:-true}" == true ]]; then
    RED="\033[31m"
    GREEN="\033[32m"
    YELLOW="\033[33m"
    BLUE="\033[34m"
    MAGENTA="\033[35m"
    CYAN="\033[36m"
    BOLD="\033[1m"
    RESET="\033[0m"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    MAGENTA=""
    CYAN=""
    BOLD=""
    RESET=""
fi

# Funciones helper
cecho() {
    local color="$1"; shift
    echo -e "${color}$*${RESET}"
}

