# VARIABLES DECLARED

######################
# REQUIRED VARIABLES #
######################
variable "assume_role_policy" {
  description = "Policy that grants an entity (EC2) permission to assume the role"
  type        = string
  default     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

variable "iam_instance_profile_name" {
  description = "Name of IAM Instance Profile"
  type        = string
}

variable "iam_role_name" {
  description = "Name of IAM Role"
  type        = string
}

variable "iam_role_policy_name" {
  description = "Name of IAM Role Policy"
  type        = string
}

variable "policy" {
  description = "The policy document attached to the role"
  type        = string
}

######################
# OPTIONAL VARIABLES #
######################
# INSTANCE PROFILE
variable "profile_path" {
  description = "Path to the IAM instance profile"
  type        = string
  default     = "/"
}

# ROLE
variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "role_path" {
  description = "Path to the IAM role"
  type        = string
  default     = "/"
}

########
# TAGS #
########
variable "iam_instance_tags" {
  description = "Tags for IAM Instance"
  type        = map(string)  # string, number, bool, list, map
}

variable "iam_role_tags" {
  description = "Tags for IAM Role"
  type        = map(string)  # string, number, bool, list, map
}
