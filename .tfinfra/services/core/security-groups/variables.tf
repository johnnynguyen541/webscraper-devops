# VARIABLES DECLARED

###################
# LOCAL VARIABLES #
###################
locals {
  # ROLE TAGS
  bastion_tag     = "bastion"
  sandbox_tag     = "sandbox"
  ssh_tag         = "ssh"
  # RESOURCE TAGS
  sg_resource_tag = "sg"
  scrape_alb      = "scrape_alb"
  scrape_ec2      = "scrape_ec2"
}

######################
# REQUIRED VARIABLES #
######################
variable "private_subnets" {
  description = "List of all private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of all public subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "AWS Region Hosted"
  type        = string
}

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

variable "role_tags" {
  description = "Tag - Resource Roles"
  type        = map(string)  # string, number, bool, list, map
}

variable "subenv_tag" {
  description = "Tag - Sub Environment Name"
  type        = string  # string, number, bool, list, map
}
