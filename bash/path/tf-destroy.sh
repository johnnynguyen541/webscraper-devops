#!/bin/bash

# Run Terraform Destroy Command
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

    secretVars="../../secret.tfvars"
    envVars="../../env.tfvars"
    subenvVars="../subenv.tfvars"
    featureVars="feature.tfvars"

    echo "secretVars = $secretVars"
    echo "envVars = $envVars"
    echo "subenvVars = $subenvVars"
    echo "featureVars = $featureVars"

    if [ ! -f $secretVars ]; then
        echo "Secret Vars does not exist."
        exit 1
    elif [ ! -f $envVars ]; then
        echo "Env Vars does not exist."
        exit 1
    elif [ ! -f $subenvVars ]; then
        echo "Sub Env Vars does not exist."
        exit 1
    elif [ ! -f $featureVars ]; then
        echo "Feature Vars does not exist."
        exit 1
    fi
}


terraform_destroy_cmd() {
    echo "terraform plan -var-file=\"../../secret.tfvars\" \\"
    echo "  -var-file=\"../../env.tfvars\" \\"
    echo "  -var-file=\"../subenv.tfvars\" \\"
    echo "  -var-file=\"feature.tfvars\" \\"
    echo "  -var \"commit_tag=$(git rev-parse --short HEAD)\" \\"
    echo "  -out plan.out \\"
    echo "  -destroy"

    terraform plan -var-file="../../secret.tfvars" \
        -var-file="../../env.tfvars" \
        -var-file="../subenv.tfvars" \
        -var-file="feature.tfvars" \
        -var "commit_tag=$(git rev-parse --short HEAD)" \
        -out plan.out \
        -destroy
}

# Define Main Function
terraform_destroy() {
    echo "--------------------------"
    echo "Running Terraform Destroy:"
    echo "--------------------------"

    check_terraform_version
    check_terraform_files
    check_terraform_var_files
    terraform_destroy_cmd
}

terraform_destroy
