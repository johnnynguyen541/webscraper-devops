#!/bin/bash 
#=========================================================================
# title          :  install-lint-bash.sh
# description    :  Install Bash Linter - Shell Check
# author         :  Johnny Nguyen
# date           :  06-11-2022
# version        :  1.0
# usage          :  sudo ./install-lint-bash.sh
# notes          :  Install Bash Linter from Shellcheck Dir
#=========================================================================

# Variables
INSTALL_CFG_PATH="$(dirname "$(readlink -f "$0")")/cfg/install.cfg"

# shellcheck source=/dev/null
. "${INSTALL_CFG_PATH}"

install_shellcheck() {
    echo "$(date): Checking Linux Distribution "

    if [[ $LINUX_DISTRO == 'Ubuntu'* ]]; then
        tput setaf 2; echo -e "Operating System: $LINUX_DISTRO"; tput sgr0

        echo "Install Shell Check libraries for Ubuntu"
        xargs -a "$PROJECT_DIR_PATH"/lint/lint-bash-ubuntu.txt apt install

    elif [[ $LINUX_DISTRO == 'Linuxmint'* ]]; then
        tput setaf 2; echo -e "Operating System: $LINUX_DISTRO"; tput sgr0

        echo "Install Shell Check libraries for Linux Mint"
        xargs -a "$PROJECT_DIR_PATH"/lint/lint-bash-linuxmint.txt apt install
    else
        tput setaf 1; echo "Sorry but this script only runs on Linux."; tput sgr0
        echo ""
        
        exit 1
    fi
}

test_shellcheck() {
    echo "$(date): Testing $SHELLCHECK_CMD"

    if ! command -v "$SHELLCHECK_CMD" &> /dev/null
    then
        echo "$SHELLCHECK_CMD command could not be found"
        exit 1
    else
        echo "$SHELLCHECK_CMD command found"
    fi
}

install_shellcheck
test_shellcheck
