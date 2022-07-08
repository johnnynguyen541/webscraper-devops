# MODULES USED IN FEATURE
module "ec2_jumpbox" {
  source          = "../../../../modules/ec2-singular"

  # REQUIRED VARIABLES
  ami                    = var.ubuntu_2204_arm_ami[var.region]
  instance_type          = var.instance_type
  key_name               = var.aws_key_name
  vpc_security_group_ids = [
    data.terraform_remote_state.security.outputs.sandbox_sg_id,
    data.terraform_remote_state.security.outputs.ssh_sg_id
  ]

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.jumpbox]}-${var.role_tags[local.ec2_instance_tag]}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = var.role_tags[local.ec2_instance_tag]
    Role        = var.role_tags[local.jumpbox]
  }
}
