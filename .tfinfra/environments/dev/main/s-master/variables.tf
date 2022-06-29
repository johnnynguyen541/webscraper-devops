# VARIABLES DECLARED

# ENV
variable "ami_2004" {
  description = "AMI ID of Ubuntu 20.04 Instance"
  type        = string
}

variable "region" {
  description = "AWS Region Hosted"
  type        = string
}

# SECRETS

# SUBENV

# FEATURE
variable "aws_key_name" {
  description = "AWS Key used for Instances"
  type        = string  # string, number, bool, list, map
  default     = null
}

variable "ami_instance_type" {
  description = "AMI instance type.  Default to Free Tier"
  type        = string  # string, number, bool, list, map
  default     = "t2.micro"
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name"
  type        = string  # string, number, bool, list, map
  default     = null
}

variable "userdata" {
  description = "The user data to provide when launching the instance"
  type        = string  # string, number, bool, list, map
  default     = null
}

# TAGS
variable "account_tag" {
  description = "Tag - Account Name"
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
