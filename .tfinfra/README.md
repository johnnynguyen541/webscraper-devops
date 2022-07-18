# Terraform

# Table of Contents
1. [Setup](#Setup)
2. [General Structure](#General-Structure)
3. [Modules](#Modules)
4. [Services](#Services)
5. [Commands](#Commands)
6. [Naming Conventions](#Naming-Conventions)

### Setup

Folder | Description
---- | ----
**environments** | Environments Deployed
**modules** | Modular "Classes"
**services** | Services used
**templates** | Templates for the 3 above for reference

### General Structure

**Environments**
There are 2 main environments: `dev` and `prod`.

- Each environment has sub environments.  For example, `prod` may have `staging` and `prod`.
  - `dev/`
    - `core` -> Core Infrastructure
    - `main` -> Main Environment
  - `prod/`
    - `core` -> Core Infrastructure
    - `main` -> Main Environment
- All environments have `core` resources for each environment (ie network, security groups, iam roles).
  - Sub-environments all use `core` components.  This means they could use the same VPC, Subnets, etc.
- Each sub environment has `$FEATURE/` directory corresponding to a service/set of services (general or core).

**Variable** files used are as follows:
- `$ENV/` -> Environment Directory
- `secret.tfvars` -> Keys and Secrets
- `env.tfvars` -> General Environment Variables (ie. Region, Networking, Tags)
  - `$SUBENV/` -> Sub Environment
  - `subenv.tfvars` -> Sub Environment Variables (ie. Sub Env Tags)
    - `$FEATURE/` -> Feature Directory
    - `feature.tfvars` -> Feature Environment Variables (ie. # of Clusters)
 
Each **$FEATURE/** directory contains files used as follows:

File             | Description                                | Example
-----------------|--------------------------------------------| ----
`*.tftpl`        | Template files (if needed)                 | bootstrap.sh.tftpl
`backend.tf`     | What Backend is used                       | S3 Bucket, etc.
`data.tf`        | Data used from external sources            | Templates, Files, states
`feature.tfvars` | Feature Environment Variables              | # of Clusters  
`main.tf`        | All modules and services used              | Networking, ASG Modules
`outputs.tf`     | Outputs for State/Resource                 | vpc_id, subnets
`providers.tf`   | Providers Used                             | `aws`, `gcp`, `azure`
`s3_backend.tf`  | S3 Backend Settings                        | `bucket`, `key`, `region`, `encrypt`
`variables.tf`   | List of Variables used with their defaults | Number of Instances, AMI type
`versions.tf`    | Required Version of Terraform              | `>= 1.0`

Each **$MODULE/** and **SERVICE/** directory contains files used as follows:

File                        | Description                                 | Example
----------------------------|---------------------------------------------| ----
`data.tf`                   | Data used from external sources (if needed) | Templates, Files, states
`main.tf` or `$RESOURCE.tf` | All modules and services used               | Networking, ASG Modules
`outputs.tf`                | Outputs for State/Resource                  | vpc_id, subnets
`variables.tf`              | List of Variables used with their defaults  | Number of Instances, AMI type
`versions.tf`               | Required Version of Terraform               | `>= 1.0`

Each **Resource** should have the following tags:

Tag Name     | Description      | Convention                                      | Example
-------------|------------------|-------------------------------------------------| ----
Name         | Name of Resource | `${env}-${subenv}-${project}-${role}-${resource}` | `dev-core-webscraper-infra-vpc`
Account      | Account Name     | `${account_tag}`                                  | `johnny_aws`
Commit       | Git Commit SHA   | `$(git rev-parse --short HEAD)` | `7ef9d38`
Environment  | Environment Name | `${env_tag}-${subenv_tag}`                        | `dev-core`
Project      | Project Name     | `${project_tag}`                                  | `webscraper`
Resource     | Resource Type    | `${resource_tag}`                                 | `ec2`, `alb`, `sg`, `asg`, `vpc`
Role         | Resource Role    | `${role_tag}`                                     | `bastion`, `webserver`, `api`, `mysql`, `infra`

These Tags are explicitly defined when using modules.  However, when using a module in `services/` directory, it should create the tags for you (which of course could reference `modules` in itself).  For example:

```HCL
# IAM MODULE CALL
module "iam" {
  source          = "../../../../modules/iam-ec2"

  # TAGS
  iam_instance_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.iam_instance_tag}"
    Account     = var.account_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.iam_instance_tag
    Role        = var.role_tags[local.core_server]
  }

  iam_role_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.iam_role_tag}"
    Account     = var.account_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.iam_role_tag
    Role        = var.role_tags[local.core_server]
  }
}

# SG MODULE CALL
module "security_groups" {
  source          = "../../../../services/core/security-groups"

  # TAGS
  account_tag     = var.account_tag
  commit_tag      = var.commit_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tags       = var.role_tags
  subenv_tag      = var.subenv_tag
}
```

### Modules
Modular Resources, meant to be either a single wrapper of resources (or very small clusters).

### Services
Service resources are grouped resources meant to serve a purpose.
They are modular, and called from `$ENV/SUBENV/FEATURE/main.tf`
Services can be broken into `general` and `core` services, each their own directory

### Commands
To run Terraform commands:

```bash
terraform init -backend-config="s3_backend.tfvars" \
               -var-file="../../secret.tfvars" \
               -var-file="../../env.tfvars"
terraform plan -var-file="../../secret.tfvars" \
               -var-file="../../env.tfvars" \
               -var-file="../subenv.tfvars" \
               -var-file="feature.tfvars" \
               -var "commit_tag=$(git rev-parse --short HEAD)" \
               -out plan.out
terraform apply plan.out
```

To delete:
```bash
terraform init -backend-config="s3_backend.tfvars" \
               -var-file="../../secret.tfvars" \
               -var-file="../../env.tfvars"
terraform plan -var-file="../../secret.tfvars" \
               -var-file="../../env.tfvars" \
               -var-file="../subenv.tfvars" \
               -var-file="feature.tfvars" \
               -var "commit_tag=$(git rev-parse --short HEAD)" \
               -out plan.out \
               -destroy
terraform apply plan.out
```

### Naming Conventions

Item                          | Case
------------------------------|-----
folders                       | dash-case
strings                       | dash-case
files                         | snake_case
resources, variables, modules | snake_case
sub tags, subnames            | snake_case
comments, placeholders        | CAPS_CASE
