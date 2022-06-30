# MODULES USED IN FEATURE
module "networking" {
  source          = "../../../../services/core/networking"

  # REQUIRED VARIABLES
  availability_zones = var.availability_zones[var.region]
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  vpc_cidr           = var.vpc_cidr

  # OPTIONAL VARIABLES

  # OTHER VARIABLES
  num_of_azs         = var.num_of_azs
  enable_elastic_ips = var.enable_elastic_ips

  # TAGS
  account_tag        = var.account_tag
  commit_tag         = var.commit_tag
  env_tag            = var.env_tag
  project_tag        = var.project_tag
  role_tags          = var.role_tags
  subenv_tag         = var.subenv_tag
}
