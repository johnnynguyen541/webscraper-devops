# TERRAFORM REQUIRED VERSIONS
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      version = ">3.44"
      source  = "hashicorp/aws"
    }
  }
}
