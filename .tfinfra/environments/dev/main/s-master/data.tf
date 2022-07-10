# INPUT DATA USED FOR TERRAFORM SCRIPT
data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket  = "webscraper-infrastructure"
    key     = "tfstate/dev/core/networking.tfstate"
    region  = var.region
    encrypt = false
  }
}

data "terraform_remote_state" "security" {
  backend = "s3"
  config = {
    bucket  = "webscraper-infrastructure"
    key     = "tfstate/dev/core/security.tfstate"
    region  = var.region
    encrypt = false
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket  = "webscraper-infrastructure"
    key     = "tfstate/dev/core/iam.tfstate"
    region  = var.region
    encrypt = false
  }
}

# MASTER BOOTSTRAP
data "template_cloudinit_config" "bootstrap_master" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.cloudinit_bootstrap_master.rendered
  }
}

data "template_file" "cloudinit_bootstrap_master" {
  template = file("${path.module}/cloudinit_bootstrap.sh.tpl")
  vars = {
    env_tag    = "${var.env_tag}-${var.subenv_tag}"
    region     = var.region
    role_tag   = var.role_tags["s_master"]
    s3_bucket  = var.s3_bucket_name
  }
}

# SLAVE 1 BOOTSTRAP
data "template_cloudinit_config" "bootstrap_slave_1" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.cloudinit_bootstrap_slave_1.rendered
  }
}

data "template_file" "cloudinit_bootstrap_slave_1" {
  template = file("${path.module}/cloudinit_bootstrap.sh.tpl")
  vars = {
    env_tag    = "${var.env_tag}-${var.subenv_tag}"
    region     = var.region
    role_tag   = var.role_tags["s_slave_1"]
    s3_bucket  = var.s3_bucket_name
  }
}

# SLAVE 2 BOOTSTRAP
data "template_cloudinit_config" "bootstrap_slave_2" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.cloudinit_bootstrap_slave_2.rendered
  }
}

data "template_file" "cloudinit_bootstrap_slave_2" {
  template = file("${path.module}/cloudinit_bootstrap.sh.tpl")
  vars = {
    env_tag    = var.env_tag
    region     = var.region
    role_tag   = var.role_tags["s_slave_2"]
    s3_bucket  = var.s3_bucket_name
    subenv_tag = var.subenv_tag
  }
}
