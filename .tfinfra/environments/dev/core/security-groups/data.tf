# INPUT DATA USED FOR TERRAFORM SCRIPT
data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket  = "webscraper-infrastructure"
    key     = "tfstate/dev/core/networking.tfstate"
    region  = "us-west-2"
    encrypt = false
  }
}
