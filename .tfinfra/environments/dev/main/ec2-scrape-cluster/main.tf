# MODULES USED IN FEATURE

# SERVICE MODULE
module "scrape_ec2" {
  source                      = "../../../../services/general/asg-http-alb-bootstrap"

  # REQUIRED VARIABLES
  ami                         = var.ubuntu_2204_x86_ami[var.region]
  asg_min_capacity            = var.asg_min_capacity
  asg_max_capacity            = var.asg_max_capacity
  instance_type               = var.instance_type
  vpc_id                      = data.terraform_remote_state.networking.outputs.vpc_id

  # OPTIONAL VARIABLES
  alb_name                    = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags["scrape_alb"]}"
  alb_tg_name                 = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags["scrape_tg"]}"
  alb_security_groups         = [
    data.terraform_remote_state.security.outputs.scrape_alb_sg_id
  ]
  alb_vpc_subnet_ids          = data.terraform_remote_state.networking.outputs.public_subnets_ids

  asg_desired_capacity        = var.asg_desired_capacity
  asg_name                    = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags["scrape_ec2"]}"
  asg_security_groups         = [
    data.terraform_remote_state.security.outputs.ssh_sg_id,
    data.terraform_remote_state.security.outputs.scrape_server_sg_id
  ]
  asg_vpc_subnet_ids          = data.terraform_remote_state.networking.outputs.private_subnets_ids
  associate_public_ip_address = var.associate_public_ip_address
  aws_key_name                = var.aws_key_name
  force_delete                = var.force_delete
  iam_instance_profile        = data.terraform_remote_state.iam.outputs.core_iam_profile_name
  userdata                    = data.template_cloudinit_config.bootstrap_scrape.rendered

  # TAGS
  account_tag     = var.account_tag
  commit_tag      = var.commit_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_alb_tag    = var.role_tags["scrape_alb"]
  role_alb_tg_tag = var.role_tags["scrape_tg"]
  role_ec2_tag    = var.role_tags["scrape_ec2"]
  subenv_tag      = var.subenv_tag
}
