# OUTPUTS FROM STATE FILE
output "bastion_sg_id" {
  description = "Bastion Security Group ID"
  value       = aws_security_group.bastion_server.id
}

output "sandbox_sg_id" {
  description = "Sandbox Security Group ID"
  value       = aws_security_group.sandbox_server.id
}

output "ssh_sg_id" {
  description = "SSH Security Group ID"
  value       = aws_security_group.ssh_server.id
}

output "scrape_alb_sg_id" {
  description = "Scrape ALB Security Group ID"
  value       = aws_security_group.scrape_alb.id
}

output "scrape_server_sg_id" {
  description = "Scrape EC2 Security Group ID"
  value       = aws_security_group.scrape_server.id
}
