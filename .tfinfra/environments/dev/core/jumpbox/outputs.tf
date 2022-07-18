# OUTPUTS FROM STATE FILE

output "jumpbox_id" {
  description = "The ID of the instance"
  value       = module.ec2_jumpbox.id
}

output "jumpbox_arn" {
  description = "The ARN of the instance"
  value       = module.ec2_jumpbox.arn
}

output "jumpbox_instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = module.ec2_jumpbox.instance_state
}

output "jumpbox_public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = module.ec2_jumpbox.public_ip
}

output "jumpbox_private_ip" {
  description = "The private IP address assigned to the instance."
  value       = module.ec2_jumpbox.private_ip
}
