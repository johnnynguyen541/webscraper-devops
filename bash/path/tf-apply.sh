#!/bin/bash

# Run Terraform Apply Command
check_terraform_version() {
    echo ""
    echo "Check Terraform Version:"
    echo ""
    
    if ! terraform -version;
    then
        echo "Please install Terraform before running script.  Exiting:"
        exit 1
    fi
}

check_terraform_plan_out() {
    echo ""
    echo "Check Terraform plan out in directory:"
    echo ""
    
    tfPlan="plan.out"

    if [ -f $tfPlan ];
    then
        echo "Found $tfPlan in current directory.  Continuing:"
    else
        echo "Did not find $tfPlan in current directory.  Exiting:"
        exit 1
    fi
}

terraform_apply_cmd() {
    echo "terraform apply plan.out"

    terraform apply plan.out
}

# Define Main Function
terraform_apply() {
    echo "-----------------------"
    echo "Running Terraform Apply:"
    echo "-----------------------"

    check_terraform_version
    check_terraform_plan_out
    terraform_apply_cmd
}

terraform_apply
