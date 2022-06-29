# MODULES USED IN FEATURE

# SERVICE MODULE
module "s_master" {
  source                      = "../../../../services/general/asg-lc-bootstrap"

  # REQUIRED VARIABLES
  ami                         = var.ami_2004
  instance_type               = "t2.micro"
  asg_min_capacity            = "1"
  asg_max_capacity            = "1"

  # OPTIONAL VARIABLES
  asg_desired_capacity        = "1"
  asg_name                    = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags["s_master"]}"
  associate_public_ip_address = true
  aws_key_name                = var.aws_key_name
  iam_instance_profile        = data.terraform_remote_state.iam.outputs.core_iam_profile_name
  security_groups             = [data.terraform_remote_state.security.outputs.sandbox_sg_id]
  userdata                    = data.template_cloudinit_config.bootstrap_master.rendered
  vpc_subnet_ids              = data.terraform_remote_state.networking.outputs.public_subnets_ids

  # TAGS
  account_tag     = var.account_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tag        = var.role_tags["s_master"]
  subenv_tag      = var.subenv_tag
}

module "s_slave_1" {
  source                      = "../../../../services/general/asg-lc-bootstrap"

  # REQUIRED VARIABLES
  ami                         = var.ami_2004
  instance_type               = "t2.micro"
  asg_min_capacity            = "1"
  asg_max_capacity            = "1"

  # OPTIONAL VARIABLES
  asg_desired_capacity        = "1"
  asg_name                    = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags["s_slave_1"]}"
  associate_public_ip_address = true
  aws_key_name                = var.aws_key_name
  iam_instance_profile        = data.terraform_remote_state.iam.outputs.core_iam_profile_name
  security_groups             = [data.terraform_remote_state.security.outputs.sandbox_sg_id]
  userdata                    = data.template_cloudinit_config.bootstrap_slave_1.rendered
  vpc_subnet_ids              = data.terraform_remote_state.networking.outputs.public_subnets_ids

  # TAGS
  account_tag     = var.account_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tag        = var.role_tags["s_slave_1"]
  subenv_tag      = var.subenv_tag
}

module "s_slave_2" {
  source                      = "../../../../services/general/asg-lc-bootstrap"

  # REQUIRED VARIABLES
  ami                         = var.ami_2004
  instance_type               = "t2.micro"
  asg_min_capacity            = "1"
  asg_max_capacity            = "1"

  # OPTIONAL VARIABLES
  asg_desired_capacity        = "1"
  asg_name                    = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags["s_slave_2"]}"
  associate_public_ip_address = true
  aws_key_name                = var.aws_key_name
  iam_instance_profile        = data.terraform_remote_state.iam.outputs.core_iam_profile_name
  security_groups             = [data.terraform_remote_state.security.outputs.sandbox_sg_id]
  userdata                    = data.template_cloudinit_config.bootstrap_slave_2.rendered
  vpc_subnet_ids              = data.terraform_remote_state.networking.outputs.public_subnets_ids

  # TAGS
  account_tag     = var.account_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tag        = var.role_tags["s_slave_2"]
  subenv_tag      = var.subenv_tag
}
