# IAM INSTANCE PROFILE
resource "aws_iam_instance_profile" "instance_profile" {
  # REQUIRED VARIABLES
  name = var.iam_instance_profile_name
  role = aws_iam_role.role.name

  # OPTIONAL VARIABLES
  path = var.profile_path

  # TAGS
  tags = var.iam_instance_tags
}

# IAM ROLE
resource "aws_iam_role" "role" {
  # REQUIRED VARIABLES
  assume_role_policy    = var.assume_role_policy
  name                  = var.iam_role_name

  # OPTIONAL VARIABLES
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration
  path                  = var.role_path

  # TAGS
  tags = var.iam_role_tags
}

# IAM ROLE POLICY
resource "aws_iam_role_policy" "role_policy" {
  # REQUIRED VARIABLES
  name   = var.iam_role_policy_name
  policy = var.policy
  role   = aws_iam_role.role.id
}
