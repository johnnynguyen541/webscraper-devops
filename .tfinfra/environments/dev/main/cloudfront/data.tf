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

data "terraform_remote_state" "scrape_cluster" {
  backend = "s3"
  config = {
    bucket  = "webscraper-infrastructure"
    key     = "tfstate/dev/main/ec2-scrape-cluster.tfstate"
    region  = var.region
    encrypt = false
  }
}

