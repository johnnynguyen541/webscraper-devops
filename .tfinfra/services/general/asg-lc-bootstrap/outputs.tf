# OUTPUTS FROM STATE FILE
output "asg_id" {
  description = "Auto Scaling Group ID"
  value = aws_autoscaling_group.asg.id
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value = aws_autoscaling_group.asg.name
}
