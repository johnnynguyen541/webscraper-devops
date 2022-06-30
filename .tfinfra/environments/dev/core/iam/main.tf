# IAM MODULE
module "iam" {
  source          = "../../../../modules/iam-ec2"

  # REQUIRED VARIABLES
  policy                      = data.template_file.core_iam_policy.rendered
  iam_instance_profile_name   = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.role_tags[local.iam_instance_tag]}"
  iam_role_name               = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.role_tags[local.iam_role_tag]}"
  iam_role_policy_name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.role_tags[local.iam_role_policy_tag]}"

  # TAGS
  iam_instance_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.role_tags[local.iam_instance_tag]}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.role_tags[local.iam_instance_tag]
    Role        = var.role_tags[local.core_server]
  }

  iam_role_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.role_tags[local.iam_role_tag]}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.role_tags[local.iam_role_tag]
    Role        = var.role_tags[local.core_server]
  }
}

module "prometheus" {
  source          = "../../../../modules/iam-user"

  # REQUIRED VARIABLES
  user_name   = var.role_tags[local.prometheus]
  policy_name = var.role_tags[local.prometheus]

  # TAGS
  user_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.prometheus]}-${var.role_tags[local.iam_instance_tag]}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.role_tags[local.iam_user_tag]
    Role        = var.role_tags[local.prometheus]
  }
}
