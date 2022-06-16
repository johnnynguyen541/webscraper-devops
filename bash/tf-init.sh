#!/bin/bash

# Run Terraform Init Command
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

check_terraform_files() {
    echo ""
    echo "Check Terraform files in directory:"
    echo ""
    
    tfList=$(find . -maxdepth 1 -name '*.tf')
    tfVarList=$(find . -maxdepth 1 -name '*.tfvars')

    echo "Terraform Files: $tfList"
    if [[ $tfList ]];
    then
        echo "Found .tf files in current directory.  Continuing:"
    else
        echo "Did not find .tf files in current directory.  Exiting:"
        exit 1
    fi

    echo "Terraform Variable Files: $tfVarList"
    if [[ $tfVarList ]];
    then
        echo "Found .tfvars files in current directory."
    else
        echo "Did not find .tfvars files in current directory."
    fi
}

check_terraform_var_files() {
    echo ""
    echo "Check Terraform var files in directory:"
    echo ""

    backendConfig="s3_backend.tfvars"
    secretVars="../../secret.tfvars"
    envVars="../../env.tfvars"

    echo "backendConfig = $backendConfig"
    echo "secretVars = $secretVars"
    echo "envVars = $envVars"

    if [ ! -f $backendConfig ]; then
        echo "Backend Config does not exist."
        exit 1
    elif [ ! -f $secretVars ]; then
        echo "Secret Vars does not exist."
        exit 1
    elif [ ! -f $envVars ]; then
        echo "Env Vars does not exist."
        exit 1
    fi
}

terraform_init_cmd() {
    echo "terraform init -backend-config=\"s3_backend.tfvars\" \\"
    echo "  -var-file=\"../../secret.tfvars\" \\"
    echo "  -var-file=\"../../env.tfvars\""

    terraform init -backend-config="s3_backend.tfvars" \
        -var-file="../../secret.tfvars" \
        -var-file="../../env.tfvars"
}

# Define Main Function
terraform_init() {
    echo "-----------------------"
    echo "Running Terraform Init:"
    echo "-----------------------"

    check_terraform_version
    check_terraform_files
    check_terraform_var_files
    terraform_init_cmd
}

terraform_init
