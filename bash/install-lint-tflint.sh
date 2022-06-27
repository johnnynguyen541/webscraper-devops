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
INSTALL_LIB_PATH="$(dirname "$(readlink -f "$0")")/cfg/install-library.sh"

# shellcheck source=/dev/null
. "${INSTALL_CFG_PATH}"
# shellcheck source=/dev/null
. "${INSTALL_LIB_PATH}"

install_tflint() {
    echo "Run curl"

    curl -s "$TFLINT_URL" | bash
}

install_tflint
test_command "$TFLINT_CMD"
