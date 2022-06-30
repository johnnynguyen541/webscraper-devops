# MODULES USED IN FEATURE
module "security_groups" {
  source          = "../../../../services/core/security-groups"

  # REQUIRED VARIABLES
  private_subnets  = data.terraform_remote_state.networking.outputs.private_subnets_ids
  public_subnets   = data.terraform_remote_state.networking.outputs.public_subnets_ids
  vpc_id           = data.terraform_remote_state.networking.outputs.vpc_id

  # TAGS
  account_tag     = var.account_tag
  commit_tag      = var.commit_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tags       = var.role_tags
  subenv_tag      = var.subenv_tag
}
