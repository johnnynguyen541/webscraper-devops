# VARIABLES DECLARED

###################
# LOCAL VARIABLES #
###################
locals {
  instance_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tag}-${local.ec2_tag}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.ec2_tag
    Role        = var.role_tag
  }

  # RESOURCE TAGS
  ec2_tag = "ec2"
}

######################
# REQUIRED VARIABLES #
######################
# LAUNCH CONFIGURATION
variable "ami" {
  description = "The EC2 image ID to launch"
  type        = string  # string, number, bool, list, map
}

variable "instance_type" {
  description = "The size of instance to launch"
  type        = string  # string, number, bool, list, map
}

# ASG
variable "asg_max_capacity" {
  description = "The Maximum size of the ASG"
  type        = number  # string, number, bool, list, map
}

variable "asg_min_capacity" {
  description = "The Minimum size of the ASG"
  type        = number  # string, number, bool, list, map
}

variable "security_groups" {
  description = "A list of associated security group IDS"
  type        = list(string)  # string, number, bool, list, map
  default     = null
}

######################
# OPTIONAL VARIABLES #
######################
# AWS - LAUNCH CONFIGURATION
variable "associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  type        = bool  # string, number, bool, list, map
  default     = false
}

variable "aws_key_name" {
  description = "The key name that should be used for the instance"
  type        = string  # string, number, bool, list, map
  default     = null
}

variable "create_resource_before_destroy" {
  description = "Create your new resource before destroying the old resource when making changes"
  type        = bool  # string, number, bool, list, map
  default     = true
}

variable "domain_name" {
  type        = string
  description = "The domain name to use"
  default     = null
}

variable "delete_on_termination" {
  description = "Whether the volume should be destroyed on instance termination"
  type        = bool  # string, number, bool, list, map
  default     = true
}

variable "iam_instance_profile" {
  description = "The name attribute of the IAM instance profile to associate with launched instances"
  type        = string  # string, number, bool, list, map
  default     = null
}

variable "root_volume_size" {
  description = "The size of the volume in gigabytes"
  type        = string  # string, number, bool, list, map
  default     = 50
}

variable "root_volume_type" {
  description = "The type of volume"
  type        = string  # string, number, bool, list, map
  default     = "gp3"
}

variable "userdata" {
  description = "The user data to provide when launching the instance"
  type        = string  # string, number, bool, list, map
  default     = null
}

# ASG
variable "asg_desired_capacity" {
  description = "The Desired size of the ASG"
  type        = number  # string, number, bool, list, map
  default     = 1
}

variable "force_delete" {
  description = "Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate"
  type        = bool  # string, number, bool, list, map
  default     = true
}

variable "vpc_subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)  # string, number, bool, list, map
  default     = null
}

# ALL RESOURCES
variable "asg_name" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string  # string, number, bool, list, map
  default     = ""
}

###################
# OTHER VARIABLES #
###################
# FEATURE

########
# TAGS #
########
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

variable "role_tag" {
  description = "Tag - Resource Roles"
  type        = string  # string, number, bool, list, map
}

variable "subenv_tag" {
  description = "Tag - Sub Environment Name"
  type        = string  # string, number, bool, list, map
}
