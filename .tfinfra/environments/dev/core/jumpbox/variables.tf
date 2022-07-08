# VARIABLES DECLARED

locals {
  # ROLE TAGS
  jumpbox          = "jumpbox"
  ec2_instance_tag = "ec2"
}

# ENV
variable "region" {
  description = "AWS Region Hosted"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name"
  type        = string  # string, number, bool, list, map
  default     = null
}

variable "ubuntu_2204_arm_ami" {
  description = "ID of AMI Ubuntu 22.04 to use for the instance"
  type        = map(string)
  default     = ""
}

# SECRETS

# SUBENV

# FEATURE
variable "aws_key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

# TAGS
variable "account_tag" {
  description = "Tag - Account Name"
  type        = string  # string, number, bool, list, map
}

variable "commit_tag" {
  description = "Tag - GIT Commit ID Name"
  type        = string  # string, number, bool, list, map
}

variable "env_tag" {
  description = "Tag - Environment Name"
  type        = string  # string, number, bool, list, map
}

variable "project_tag" {
  description = "Tag - Project Name"
  type        = string  # string, number, bool, list, map
}

variable "role_tags" {
  description = "Tag - Resource Role"
  type        = map(string)  # string, number, bool, list, map
}

variable "subenv_tag" {
  description = "Tag - Sub Environment Name"
  type        = string  # string, number, bool, list, map
}


