# OUTPUTS FROM STATE FILE
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "vpc_nat_eips" {
  description = "NAT public Elastic IP addresses"
  value       = aws_eip.nat_eips[*].public_ip
}

output "public_subnets_ids" {
  description = "VPC Public Subnet ids"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnets_ids" {
  description = "VPC Public Subnet ids"
  value       = aws_subnet.private_subnets[*].id
}

output "availability_zones" {
  description = "VPC Availability Zones"
  value       = aws_subnet.private_subnets[*].availability_zone
}
