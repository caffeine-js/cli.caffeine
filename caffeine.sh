#!/bin/bash

# Abort on any error
set -e
source "$(dirname "$0")/theme.sh"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case "$1" in
    init)
        "$SCRIPT_DIR/init.sh" "${@:2}"
        ;;
    *)
        echo -e "${RED}${LOGO} Usage: ${CYAN}caffeine {init``}${NC}"
        exit 1
        ;;
esac
