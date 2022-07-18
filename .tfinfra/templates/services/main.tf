# MODULES/FEATURES USED IN FEATURE

/*
# MODULE
module "NAME_OF_MODULE" {
  source          = "../../../../modules/MODULE_NAME"

  # REQUIRED VARIABLES
  module_variable = var.local_variable_declared

  # OPTIONAL VARIABLES
  module_variable = var.local_variable_declared

  # OTHER VARIABLES
  module_variable = var.local_variable_declared

  # TAGS
  account_tag     = var.account_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tag        = var.ROLE_TAG_VAR
  subenv_tag      = var.subenv_tag
}

# RESOURCE
resource "RESOURCE_TYPE" "RESOURCE_NAME" {
  # REQUIRED VARIABLES
  resource_variables = var.local_variable_declared

  # OPTIONAL VARIABLES
  resource_variables = var.local_variable_declared

  # OTHER VARIABLES
  resource_variables = var.local_variable_declared

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.ROLE_TAG_VAR}-${local.RESOURCE_TYPE_VAR}"
    Account     = var.account_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.RESOURCE_TYPE_VAR
    Role        = var.ROLE_TAG_VAR
  }
}
*/