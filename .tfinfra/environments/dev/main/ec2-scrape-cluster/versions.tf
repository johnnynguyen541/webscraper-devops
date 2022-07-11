# TERRAFORM REQUIRED VERSIONS
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      version = ">= 4.15.0"
      source  = "hashicorp/aws"
    }
  }
}
