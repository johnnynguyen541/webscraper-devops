#!/bin/bash 
#=========================================================================
# title          :  install-lint-tflint.sh
# description    :  Install Terraform Linter - tflint
# author         :  Johnny Nguyen
# date           :  06-12-2022
# version        :  1.0
# usage          :  sudo ./install-lint-tflint.sh
# notes          :  Install tflint Linter for Terraform
#=========================================================================

# Variables
INSTALL_CFG_PATH="$(dirname "$(readlink -f "$0")")/cfg/install.cfg"

# shellcheck source=/dev/null
. "${INSTALL_CFG_PATH}"

install_tflint() {
    echo "Run curl"

    curl -s "$TFLINT_URL" | bash
}

test_tflint() {
    echo "$(date): Testing $TFLINT_CMD"

    if ! command -v "$TFLINT_CMD" &> /dev/null
    then
        echo "$TFLINT_CMD command could not be found"
        exit 1
    else
        echo "$TFLINT_CMD command found"
    fi
}

install_tflint
test_tflint
