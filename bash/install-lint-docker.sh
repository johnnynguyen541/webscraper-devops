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
INSTALL_LIB_PATH="$(dirname "$(readlink -f "$0")")/cfg/install-library.sh"

# shellcheck source=/dev/null
. "${INSTALL_CFG_PATH}"
# shellcheck source=/dev/null
. "${INSTALL_LIB_PATH}"

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

install_hadolint
test_command "$HADOLINT_CMD"
