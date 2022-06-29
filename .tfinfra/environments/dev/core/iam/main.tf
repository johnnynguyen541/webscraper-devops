# IAM MODULE
module "iam" {
  source          = "../../../../modules/iam-ec2"

  # REQUIRED VARIABLES
  policy                      = data.template_file.core_iam_policy.rendered
  iam_instance_profile_name   = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.iam_instance_tag}"
  iam_role_name               = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.iam_role_tag}"
  iam_role_policy_name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.iam_role_policy_tag}"

  # TAGS
  iam_instance_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.iam_instance_tag}"
    Account     = var.account_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.iam_instance_tag
    Role        = var.role_tags[local.core_server]
  }

  iam_role_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.core_server]}-${var.iam_role_tag}"
    Account     = var.account_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.iam_role_tag
    Role        = var.role_tags[local.core_server]
  }
}

module "prometheus" {
  source          = "../../../../modules/iam-user"

  # REQUIRED VARIABLES
  user_name   = var.prometheus_iam_user_name
  policy_name = var.prometheus_iam_user_name

  # TAGS
  user_tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.prometheus]}-${var.iam_instance_tag}"
    Account     = var.account_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.iam_user_tag
    Role        = var.role_tags[local.prometheus]
  }
}
