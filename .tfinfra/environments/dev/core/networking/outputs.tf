# OUTPUTS FROM STATE FILE
output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "vpc_nat_eips" {
  description = "NAT public Elastic IP addresses"
  value       = module.networking.vpc_nat_eips
}

output "public_subnets_ids" {
  description = "VPC Public Subnet ids"
  value       = module.networking.public_subnets_ids
}

output "private_subnets_ids" {
  description = "VPC Public Subnet ids"
  value       = module.networking.private_subnets_ids
}

output "availability_zones" {
  description = "VPC Availability Zones"
  value       = module.networking.availability_zones
}
