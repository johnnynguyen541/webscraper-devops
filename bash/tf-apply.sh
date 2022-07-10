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

check_terraform_plan_out() {
    echo ""
    cyan_print "Check Terraform plan out in directory:"
    echo ""
    
    tfPlan="plan.out"

    if [ -f $tfPlan ];
    then
        green_print "Found $tfPlan in current directory.  Continuing:"
    else
        red_print "Did not find $tfPlan in current directory.  Exiting:\n"
        exit 1
    fi
}

terraform_apply_cmd() {
    echo ""
    cyan_print "Run Terraform Apply Command:"
    echo ""
    
    echo "terraform apply plan.out"

    terraform apply plan.out
}

# Define Main Function
terraform_apply() {
    cyan_print "------------------------"
    cyan_print "Running Terraform Apply:"
    cyan_print "------------------------"

    check_terraform_version
    check_terraform_plan_out
    terraform_apply_cmd
}

terraform_apply
