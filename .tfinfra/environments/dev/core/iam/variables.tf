# VARIABLES DECLARED

# LOCAL
locals {
  # ROLE TAGS
  core_server     = "core_server"
  prometheus      = "prometheus"
}

# ENV
variable "region" {
  description = "AWS Region Hosted"
  type        = string
}

# FEATURE
variable "prometheus_iam_user_name" {
  description = "Prometheus IAM User name"
  type        = string
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

variable "iam_instance_tag" {
  description = "Tag - IAM Instance"
  type        = string  # string, number, bool, list, map
}

variable "iam_role_tag" {
  description = "Tag - IAM Role"
  type        = string  # string, number, bool, list, map
}

variable "iam_role_policy_tag" {
  description = "Tag - IAM Role Policy"
  type        = string  # string, number, bool, list, map
}

variable "iam_user_tag" {
  description = "Tag - IAM User"
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
