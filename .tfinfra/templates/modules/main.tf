# MODULES/FEATURES USED IN FEATURE

/*
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
    Name        = "${var.env_tag|-${var.subenv_tag}-${var.project_tag}-${var.ROLE_TAG_VAR}-${local.RESOURCE_TYPE_VAR}"
    Account     = var.account_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.RESOURCE_TYPE_VAR
    Role        = var.ROLE_TAG_VAR
  }
}
*/