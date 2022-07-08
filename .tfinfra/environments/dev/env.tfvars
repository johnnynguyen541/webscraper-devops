# General
ubuntu_2204_arm_ami = {
  us-west-1 = "ami-04ba89d2da768a527",
  us-west-2 = "ami-076d7bf6ac3493160",
  us-east-1 = "ami-02ddaf75821f25213",
  us-east-2 = "ami-0717cbd2f49a61ed0"
}

ubuntu_2204_x86_ami = {
  us-west-1 = "ami-0dc5e9ff792ec08e3",
  us-west-2 = "ami-0ee8244746ec5d6d4",
  us-east-1 = "ami-09d56f8956ab235b3",
  us-east-2 = "ami-0aeb7c931a5a61206"
}

providers           = ["aws"]
region              = "us-west-2"
s3_bucket_name      = "webscraper-infrastructure"

# Tags
account_tag         = "johnny_aws"
env_tag             = "dev"
project_tag         = "webscraper"
vpc_cidr            = "10.0.0.0/16"

# Subnets
num_of_azs          = 2
availability_zones  = {
  us-west-1 = [
    "us-west-1a",
    "us-west-1b",
    "us-west-1c"
  ],
  us-west-2 = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c",
    "us-west-2d"
  ],
  us-east-1 = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1e",
    "us-east-1f"
  ],
  us-east-2 = [
    "us-east-2a",
    "us-east-2b",
    "us-east-2c"
  ]
}

public_subnets      = [
  "10.0.0.0/24",
  "10.0.2.0/24",
  "10.0.4.0/24",
  "10.0.6.0/24",
  "10.0.8.0/24",
  "10.0.10.0/24"
]
private_subnets     = [
  "10.0.1.0/24",
  "10.0.3.0/24",
  "10.0.5.0/24",
  "10.0.7.0/24",
  "10.0.9.0/24",
  "10.0.11.0/24"
]

# Role Tags
role_tags = {
  # CORE
  infra       = "infra",      # Core Networking Infrastructure
  bastion     = "bastion",    # Core Security Groups
  jumpbox     = "jumpbox",
  ssh         = "ssh",
  sandbox     = "sandbox",
  core_server = "core_server", # Core IAM Group
  prometheus  = "prometheus",  # Prometheus User

  iam_instance_tag        = "iam_profile",
  iam_role_tag            = "iam_role",
  iam_role_policy_tag     = "iam_policy",
  iam_user_tag            = "iam_user"
}