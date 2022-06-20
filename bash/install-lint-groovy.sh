#!/bin/bash 
#=========================================================================
# title          :  install-lint-groovy.sh
# description    :  Install Groovy Linter - npm-groovy-lint
# author         :  Johnny Nguyen
# date           :  06-16-2022
# version        :  1.0
# usage          :  sudo ./install-lint-groovy.sh
# notes          :  Install npm-groovy-lint https://github.com/nvuillam/npm-groovy-lint
#=========================================================================

# Variables
INSTALL_CFG_PATH="$(dirname "$(readlink -f "$0")")/cfg/install.cfg"

# shellcheck source=/dev/null
. "${INSTALL_CFG_PATH}"

install_npm_groovy_lint() {
    echo "$(date): Checking Linux Distribution "

    if [[ $LINUX_DISTRO == 'Ubuntu'* ]]; then
        tput setaf 2; echo -e "Operating System: $LINUX_DISTRO"; tput sgr0

        echo "Install Node.js Libraries for Ubuntu"
        xargs -a "$PROJECT_DIR_PATH"/lint/lint-groovy-ubuntu.txt apt install

        echo "Install npm-groovy-lint"
        npm install -g npm-groovy-lint
    elif [[ $LINUX_DISTRO == 'Linuxmint'* ]]; then
        tput setaf 2; echo -e "Operating System: $LINUX_DISTRO"; tput sgr0

        echo "Install Node.js Libraries for Linux Mint"
        xargs -a "$PROJECT_DIR_PATH"/lint/lint-groovy-linuxmint.txt apt install

        echo "Install npm-groovy-lint"
        npm install -g npm-groovy-lint
    else
        tput setaf 1; echo "Sorry but this script only runs on Linux."; tput sgr0
        echo ""
        
        exit 1
    fi
}

test_npm_groovy_lint() {
    echo "$(date): Testing $GROOVY_CMD"

    if ! command -v "$GROOVY_CMD" &> /dev/null
    then
        echo "$GROOVY_CMD command could not be found"
        exit 1
    else
        echo "$GROOVY_CMD command found"
    fi
}

install_npm_groovy_lint
test_npm_groovy_lint
