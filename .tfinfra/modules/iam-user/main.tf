# IAM USER PROFILE
resource "aws_iam_user" "user" {
  # REQUIRED VARIABLES
  name                 = var.user_name

  # OPTIONAL VARIABLES
  force_destroy        = var.user_force_destroy
  path                 = var.user_path
  permissions_boundary = var.user_permissions_boundary

  # TAGS
  tags                 = var.user_tags
}

# IAM USER POLICY
resource "aws_iam_user_policy" "policy" {
  # REQUIRED VARIABLES
  user   = aws_iam_user.user.name

  # OPTIONAL VARIABLES
  name   = var.policy_name
  policy = var.policy
}

# IAM KEY
resource "aws_iam_access_key" "key" {
  # REQUIRED VARIABLES
  user    = aws_iam_user.user.name

  # OPTIONAL VARIABLES
  pgp_key = var.pgp_key
  status  = var.iam_key_status
}
