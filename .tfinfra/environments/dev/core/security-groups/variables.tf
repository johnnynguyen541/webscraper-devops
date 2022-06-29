# VARIABLES DECLARED

# ENV
variable "region" {
  description = "AWS Region Hosted"
  type        = string
}

variable "private_subnets" {
  description = "List of all private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of all public subnets"
  type        = list(string)
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
  description = "Tag - Resource Roles"
  type        = map(string)  # string, number, bool, list, map
}

variable "subenv_tag" {
  description = "Tag - Sub Environment Name"
  type        = string  # string, number, bool, list, map
}
