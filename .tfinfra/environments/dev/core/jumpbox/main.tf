# MODULES USED IN FEATURE

/*
# SERVICE MODULE
module "NAME_OF_SERVICE" {
  source          = "../../../../services/SERVICE_TYPE/MODULE_NAME"

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
*/