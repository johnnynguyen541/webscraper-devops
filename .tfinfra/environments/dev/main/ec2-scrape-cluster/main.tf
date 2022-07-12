# MODULES USED IN FEATURE

# SERVICE MODULE
module "scrape_ec2" {
  source                      = "../../../../services/general/asg-alb-lc-bootstrap"

  # REQUIRED VARIABLES
  ami                         = var.ubuntu_2204_x86_ami[var.region]
  instance_type               = var.instance_type
  asg_min_capacity            = var.asg_min_capacity
  asg_max_capacity            = var.asg_max_capacity

  # OPTIONAL VARIABLES
  asg_desired_capacity        = var.asg_desired_capacity
  asg_name                    = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags["scrape_ec2"]}"
  associate_public_ip_address = var.associate_public_ip_address
  aws_key_name                = var.aws_key_name
  force_delete                = var.force_delete
  iam_instance_profile        = data.terraform_remote_state.iam.outputs.core_iam_profile_name
  security_groups             = [
    data.terraform_remote_state.security.outputs.ssh_sg_id,
    data.terraform_remote_state.security.outputs.scrape_alb_sg_id
  ]
  userdata                    = data.template_cloudinit_config.bootstrap_scrape.rendered
  vpc_subnet_ids              = data.terraform_remote_state.networking.outputs.private_subnets_ids

  # TAGS
  account_tag     = var.account_tag
  commit_tag      = var.commit_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tag        = var.role_tags["scrape_ec2"]
  subenv_tag      = var.subenv_tag
}
