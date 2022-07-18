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

# SCRAPE EC2 BOOTSTRAP
data "template_cloudinit_config" "bootstrap_scrape" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.cloudinit_bootstrap_scrape.rendered
  }
}

data "template_file" "cloudinit_bootstrap_scrape" {
  template = file("${path.module}/cloudinit_bootstrap.sh.tpl")
  vars = {
    env_tag    = "${var.env_tag}-${var.subenv_tag}"
    region     = var.region
    role_tag   = var.role_tags["scrape_ec2"]
    s3_bucket  = var.s3_bucket_name
  }
}
