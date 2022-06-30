# MODULES/FEATURES USED IN FEATURE
# BASTION
resource "aws_security_group" "bastion_server" {
  # REQUIRED VARIABLES
  description        = "Bastion security group for public SSH inbound"
  vpc_id             = var.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 22
    to_port          = 22
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    protocol         = "tcp"
    from_port        = 22
    to_port          = 22
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = -1
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    protocol         = -1
    from_port        = 0
    to_port          = 0
    ipv6_cidr_blocks = ["::/0"]
  }

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.bastion_tag]}-${local.sg_resource_tag}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.sg_resource_tag
    Role        = var.role_tags[local.bastion_tag]
  }
}

# SANDBOX
resource "aws_security_group" "sandbox_server" {
  # REQUIRED VARIABLES
  description        = "Completely Open Resource"
  vpc_id             = var.vpc_id

  ingress {
    protocol         = -1
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    protocol         = -1
    from_port        = 0
    to_port          = 0
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol         = -1
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    protocol         = -1
    from_port        = 0
    to_port          = 0
    ipv6_cidr_blocks = ["::/0"]
  }

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.sandbox_tag]}-${local.sg_resource_tag}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.sg_resource_tag
    Role        = var.role_tags[local.sandbox_tag]
  }
}

# SSH
resource "aws_security_group" "ssh_server" {
  # REQUIRED VARIABLES
  description        = "SSH Internal Access for Resources"
  vpc_id             = var.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 22
    to_port          = 22
    self             = true
  }

  egress {
    protocol         = -1
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    protocol         = -1
    from_port        = 0
    to_port          = 0
    ipv6_cidr_blocks = ["::/0"]
  }

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.ssh_tag]}-${local.sg_resource_tag}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.sg_resource_tag
    Role        = var.role_tags[local.ssh_tag]
  }
}
