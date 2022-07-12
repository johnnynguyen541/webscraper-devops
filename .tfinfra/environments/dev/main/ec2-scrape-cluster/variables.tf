# VARIABLES DECLARED

# ENV
variable "ubuntu_2204_x86_ami" {
  description = "ID of AMI Ubuntu 22.04 to use for the instance"
  type        = map(string)
  default     = null
}

variable "region" {
  description = "AWS Region Hosted"
  type        = string
}

# SECRETS

# SUBENV

# FEATURE
variable "asg_desired_capacity" {
  description = "The Desired size of the ASG"
  type        = number  # string, number, bool, list, map
  default     = 1
}

variable "asg_max_capacity" {
  description = "The Maximum size of the ASG"
  type        = number  # string, number, bool, list, map
}

variable "asg_min_capacity" {
  description = "The Minimum size of the ASG"
  type        = number  # string, number, bool, list, map
}

variable "associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  type        = bool  # string, number, bool, list, map
  default     = false
}

variable "aws_key_name" {
  description = "AWS Key used for Instances"
  type        = string  # string, number, bool, list, map
  default     = null
}

variable "domain_name" {
  type        = string
  description = "The domain name to use"
  default     = null
}

variable "instance_type" {
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
