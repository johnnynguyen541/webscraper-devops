#!/bin/bash 
#=========================================================================
# title          :  install-lint-docker.sh
# description    :  Install Bash Docker Linter - hadolint
# author         :  Johnny Nguyen
# date           :  06-12-2022
# version        :  1.0
# usage          :  sudo ./install-lint-docker.sh
# notes          :  Install Hadolint Linter for Docker
#=========================================================================

# Variables
INSTALL_CFG_PATH="$(dirname "$(readlink -f "$0")")/cfg/install.cfg"

# shellcheck source=/dev/null
. "${INSTALL_CFG_PATH}"

install_hadolint() {
    echo "Run wget"

    wget -O "$HADOLINT_BIN" "$HADOLINT_URL"

    if [[ -f /bin/hadolint ]]; then
        tput setaf 2; echo -e "$HADOLINT_BIN downloaded.  Updating Permissions"; tput sgr0

        chmod +x "$HADOLINT_BIN"
    else
        tput setaf 1; echo "$HADOLINT_BIN not downloaded.  Exiting"; tput sgr0
        echo ""
        
        exit 1
    fi
}

test_hadolint() {
    echo "$(date): Testing $HADOLINT_CMD"

    if ! command -v "$HADOLINT_CMD" &> /dev/null
    then
        echo "$HADOLINT_CMD command could not be found"
        exit 1
    else
        echo "$HADOLINT_CMD command found"
    fi
}

install_hadolint
test_hadolint
