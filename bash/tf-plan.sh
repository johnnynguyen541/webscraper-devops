#!/bin/bash

# Variables
PRINT_LIB_PATH="$(dirname "$(readlink -f "$0")")/cfg/print-library.sh"

# shellcheck source=/dev/null
. "${PRINT_LIB_PATH}"

# Run Terraform Plan Command
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

    secretVars="../../secret.tfvars"
    envVars="../../env.tfvars"
    subenvVars="../subenv.tfvars"
    featureVars="feature.tfvars"

    echo "secretVars = $secretVars"
    echo "envVars = $envVars"
    echo "subenvVars = $subenvVars"
    echo "featureVars = $featureVars"

    if [ ! -f $secretVars ]; then
        red_print "Secret Vars does not exist."
        exit 1
    elif [ ! -f $envVars ]; then
        red_print "Env Vars does not exist."
        exit 1
    elif [ ! -f $subenvVars ]; then
        red_print "Sub Env Vars does not exist."
        exit 1
    elif [ ! -f $featureVars ]; then
        red_print "Feature Vars does not exist."
        exit 1
    fi
}


terraform_plan_cmd() {
    echo ""
    cyan_print "Run Terraform Plan Command:"
    echo ""

    echo "terraform plan -var-file=\"../../secret.tfvars\" \\"
    echo "  -var-file=\"../../env.tfvars\" \\"
    echo "  -var-file=\"../subenv.tfvars\" \\"
    echo "  -var-file=\"feature.tfvars\" \\"
    echo "  -var \"commit_tag=$(git rev-parse --short HEAD)\" \\"
    echo "  -out plan.out"

    terraform plan -var-file="../../secret.tfvars" \
        -var-file="../../env.tfvars" \
        -var-file="../subenv.tfvars" \
        -var-file="feature.tfvars" \
        -var "commit_tag=$(git rev-parse --short HEAD)" \
        -out plan.out
}

# Define Main Function
terraform_plan() {
    cyan_print "-----------------------"
    cyan_print "Running Terraform Plan:"
    cyan_print "-----------------------"

    check_terraform_version
    check_terraform_files
    check_terraform_var_files
    terraform_plan_cmd
}

terraform_plan
