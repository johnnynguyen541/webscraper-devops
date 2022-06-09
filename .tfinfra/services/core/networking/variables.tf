# VARIABLES DECLARED

###################
# LOCAL VARIABLES #
###################
locals {
  # ROLE TAGS
  infra_tag     = "infra"
  # RESOURCE TAGS
  eigw_tag      = "eigw"
  eip_tag       = "eip"
  igw_tag       = "igw"
  nat_tag       = "nat"
  pri_sub_tag   = "prinet"
  pri_route_tag = "pri.route"
  pub_sub_tag   = "pubnet"
  pub_route_tag = "pub.route"
  vpc_tag       = "vpc"
}

######################
# REQUIRED VARIABLES #
######################
variable "availability_zones" {
  description = "List of all AZ's"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of all private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of all public subnets"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "AWS Region Hosted"
  type        = string
}

######################
# OPTIONAL VARIABLES #
######################

###################
# OTHER VARIABLES #
###################
variable "enable_elastic_ips" {
  description = "Enable Elastic IP's in VPC Subnets"
  type        = bool  # string, number, bool, list, map
  default     = false
}

variable "num_of_azs" {
  description = "Number of AZ's/Subnets in VPC"
  type        = number  # string, number, bool, list, map
  default     = 0
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
