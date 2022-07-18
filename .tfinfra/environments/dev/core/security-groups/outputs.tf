# OUTPUTS FROM STATE FILE
output "bastion_sg_id" {
  description = "Bastion Security Group ID"
  value       = module.security_groups.bastion_sg_id
}

output "sandbox_sg_id" {
  description = "Sandbox Security Group ID"
  value       = module.security_groups.sandbox_sg_id
}

output "ssh_sg_id" {
  description = "SSH Security Group ID"
  value       = module.security_groups.ssh_sg_id
}

output "scrape_alb_sg_id" {
  description = "Scrape ALB Security Group ID"
  value       = module.security_groups.scrape_alb_sg_id
}

output "scrape_server_sg_id" {
  description = "Scrape EC2 Security Group ID"
  value       = module.security_groups.scrape_server_sg_id
}
