# VARIABLES DECLARED

# ENV
variable "availability_zones" {
  description = "List of all AZ's"
  type        = map(list(string))
}

variable "private_subnets" {
  description = "List of all private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of all public subnets"
  type        = list(string)
}

variable "region" {
  description = "AWS Region Hosted"
  type        = string
}

variable "vpc_cidr" {
  description = "AWS Region Hosted"
  type        = string
}

# FEATURE
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
