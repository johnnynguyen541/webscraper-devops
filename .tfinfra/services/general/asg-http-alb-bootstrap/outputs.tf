# OUTPUTS FROM STATE FILE
output "asg_id" {
  description = "Auto Scaling Group ID"
  value = aws_autoscaling_group.asg.id
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value = aws_autoscaling_group.asg.name
}

output "alb_id" {
  description = "ALB ID"
  value = aws_lb.alb.id
}

output "alb_dns" {
  description = "ALB DNS Name"
  value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  description = "ALB canonical hosted zone ID (for Route 53 Alias record)"
  value = aws_lb.alb.zone_id
}

output "alb_lb_id" {
  description = "ALB Listener ID"
  value = aws_lb_listener.alb_listener.id
}

output "alb_tg_id" {
  description = "ALB Target Group ID"
  value = aws_lb_target_group.alb_tg.id
}
