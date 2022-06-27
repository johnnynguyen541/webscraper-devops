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
INSTALL_LIB_PATH="$(dirname "$(readlink -f "$0")")/cfg/install-library.sh"

# shellcheck source=/dev/null
. "${INSTALL_CFG_PATH}"
# shellcheck source=/dev/null
. "${INSTALL_LIB_PATH}"

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

install_shellcheck
test_command "$SHELLCHECK_CMD"
