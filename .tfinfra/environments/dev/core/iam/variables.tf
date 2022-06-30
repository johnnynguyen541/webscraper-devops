# VARIABLES DECLARED

# LOCAL
locals {
  # ROLE TAGS
  core_server = "core_server"
  prometheus  = "prometheus"

  iam_instance_tag    = "iam_instance_tag"
  iam_role_tag        = "iam_role_tag"
  iam_role_policy_tag = "iam_role_policy_tag"
  iam_user_tag        = "iam_user_tag"
}

# ENV
variable "region" {
  description = "AWS Region Hosted"
  type        = string
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
