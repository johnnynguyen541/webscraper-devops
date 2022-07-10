#!/bin/bash

# Variables
PRINT_LIB_PATH="$(dirname "$(readlink -f "$0")")/cfg/print-library.sh"

# shellcheck source=/dev/null
. "${PRINT_LIB_PATH}"

# Run Terraform Init Command
check_terraform_version() {
    echo ""
    cyan_print "Check Terraform Version:"
    echo ""
    
    if ! terraform -version;
    then
        red_print "Please install Terraform before running script.  Exiting:"
        exit 1
    fi
}

check_terraform_files() {
    echo ""
    cyan_print "Check Terraform files in directory:"
    echo ""
    
    tfList=$(find . -maxdepth 1 -name '*.tf')
    tfVarList=$(find . -maxdepth 1 -name '*.tfvars')

    echo "Terraform Files: $tfList"
    
    if [[ $tfList ]];
    then
        green_print "Found .tf files in current directory.  Continuing:"
    else
        red_print "Did not find .tf files in current directory.  Exiting:"
        exit 1
    fi

    echo "Terraform Variable Files: $tfVarList"
    if [[ $tfVarList ]];
    then
        green_print "Found .tfvars files in current directory."
    else
        red_print "Did not find .tfvars files in current directory."
    fi
}

check_terraform_var_files() {
    echo ""
    cyan_print "Check Terraform var files in directory:"
    echo ""

    backendConfig="s3_backend.tfvars"
    secretVars="../../secret.tfvars"
    envVars="../../env.tfvars"

    echo "backendConfig = $backendConfig"
    echo "secretVars = $secretVars"
    echo "envVars = $envVars"

    if [ ! -f $backendConfig ]; then
        red_print "Backend Config does not exist."
        exit 1
    elif [ ! -f $secretVars ]; then
        red_print "Secret Vars does not exist."
        exit 1
    elif [ ! -f $envVars ]; then
        red_print "Env Vars does not exist."
        exit 1
    fi
}

terraform_init_cmd() {
    echo ""
    cyan_print "Run Terraform Init Command:"
    echo ""

    echo "terraform init -backend-config=\"s3_backend.tfvars\" \\"
    echo "  -var-file=\"../../secret.tfvars\" \\"
    echo "  -var-file=\"../../env.tfvars\""

    terraform init -backend-config="s3_backend.tfvars" \
        -var-file="../../secret.tfvars" \
        -var-file="../../env.tfvars"
}

# Define Main Function
terraform_init() {
    cyan_print "-----------------------"
    cyan_print "Running Terraform Init:"
    cyan_print "-----------------------"

    check_terraform_version
    check_terraform_files
    check_terraform_var_files
    terraform_init_cmd
}

terraform_init
