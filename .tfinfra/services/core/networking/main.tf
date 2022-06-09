# MODULES/FEATURES USED IN FEATURE

# VPC
resource "aws_vpc" "vpc" {
  # REQUIRED VARIABLES
  cidr_block                       = var.vpc_cidr

  # OPTIONAL VARIABLES
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.vpc_tag}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.vpc_tag
    Role        = var.role_tags[local.infra_tag]
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "vpc_igw" {
  # REQUIRED VARIABLES
  vpc_id = aws_vpc.vpc.id

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.igw_tag}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.igw_tag
    Role        = var.role_tags[local.infra_tag]
  }
}

# EGRESS-INTERNET GATEWAY
resource "aws_egress_only_internet_gateway" "vpc_eigw" {
  # REQUIRED VARIABLES
  vpc_id = aws_vpc.vpc.id

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.eigw_tag}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.eigw_tag
    Role        = var.role_tags[local.infra_tag]
  }
}

# PRIVATE/PUBLIC SUBNETS
resource "aws_subnet" "public_subnets" {
  # REQUIRED VARIABLES
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnets[count.index]
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 2*count.index)
  availability_zone = var.availability_zones[count.index]

  # OTHER VARIABLES
  count             = var.num_of_azs

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.pub_sub_tag}${count.index}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.pub_sub_tag
    Role        = var.role_tags[local.infra_tag]
  }
}

/* Private Subnets */
resource "aws_subnet" "private_subnets" {
  # REQUIRED VARIABLES
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets[count.index]
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 2*count.index+1)
  availability_zone = var.availability_zones[count.index]

  # OTHER VARIABLES
  count             = var.num_of_azs

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.pri_sub_tag}${count.index}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.pri_sub_tag
    Role        = var.role_tags[local.infra_tag]
  }
}

# ELASTIC IPS - enable_elastic_ips
resource "aws_eip" "nat_eips" {
  # REQUIRED VARIABLES
  vpc           = true

  # OTHER VARIABLES
  count         =  var.enable_elastic_ips ? var.num_of_azs : 0

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.eip_tag}${count.index}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.eip_tag
    Role        = var.role_tags[local.infra_tag]
  }
}

# NETWORK ATTACHED GATEWAYS
resource "aws_nat_gateway" "vpc_nats" {
  # REQUIRED VARIABLES
  allocation_id     = var.enable_elastic_ips ? aws_eip.nat_eips[count.index].id : null
  connectivity_type = var.enable_elastic_ips ? "public" : "private"
  subnet_id         = aws_subnet.public_subnets[count.index].id

  # OTHER VARIABLES
  count         = var.num_of_azs
  depends_on    = [aws_internet_gateway.vpc_igw]

  # TAGS
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.nat_tag}${count.index}"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = local.nat_tag
    Role        = var.role_tags[local.infra_tag]
  }
}

# PUBLIC ROUTE TABLE IG
resource "aws_route_table" "public_outbound_rtb" {
  # REQUIRED VARIABLES
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.vpc_igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.vpc_igw.id
  }

  # TAGS
  tags = {
    Name            = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.pub_route_tag}"
    Account         = var.account_tag
    Commit          = var.commit_tag
    Environment     = "${var.env_tag}-${var.subenv_tag}"
    Project         = var.project_tag
    Resource        = local.pub_route_tag
    Role            = var.role_tags[local.infra_tag]
  }
}

# PRIVATE ROUTE TABLE NAT
resource "aws_route_table" "private_outbound_rtb" {
  # REQUIRED VARIABLES
  vpc_id            = aws_vpc.vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc_nats[count.index].id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.vpc_igw.id
  }

  # OTHER VARIABLES
  count             = var.num_of_azs

  # TAGS
  tags = {
    Name            = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-${var.role_tags[local.infra_tag]}-${local.pri_route_tag}${count.index}"
    Account         = var.account_tag
    Commit          = var.commit_tag
    Environment     = "${var.env_tag}-${var.subenv_tag}"
    Project         = var.project_tag
    Resource        = local.pri_route_tag
    Role            = var.role_tags[local.infra_tag]
  }
}

# PUBLIC SUBNET TO ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "public_outbound" {
  # REQUIRED VARIABLES
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_outbound_rtb.id

  # OTHER VARIABLES
  count          = var.num_of_azs
}

resource "aws_route_table_association" "private_outbound" {
  # REQUIRED VARIABLES
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_outbound_rtb[count.index].id

  # OTHER VARIABLES
  count          = var.num_of_azs
}
