# VARIABLES DECLARED

######################
# REQUIRED VARIABLES #
######################
# USER
variable "user_name" {
  description = "Name of IAM User"
  type        = string
}

######################
# OPTIONAL VARIABLES #
######################
# KEY
variable "iam_key_status" {
  description = "Access key status to apply"
  type        = string
  default     = "Active"
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists"
  type        = string
  default     = null
}

# USER
variable "user_force_destroy" {
  description = "Destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices"
  type        = bool
  default     = true
}

variable "user_path" {
  description = "Path in which to create the user"
  type        = string
  default     = "/"
}

variable "user_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user"
  type        = string
  default     = null
}

# USER POLICY
variable "policy" {
  description = "The policy document"
  type        = string
  default     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:Describe*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:Describe*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:ListMetrics",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:Describe*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:Describe*",
            "Resource": "*"
        }
    ]
}
EOF
}

variable "policy_name" {
  description = "The name of the policy. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

########
# TAGS #
########
variable "user_tags" {
  description = "Tags for IAM User"
  type        = map(string)  # string, number, bool, list, map
}
