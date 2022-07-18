# OUTPUTS FROM STATE FILE
output "asg_id" {
  description = "Auto Scaling Group ID"
  value = module.scrape_ec2.asg_id
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value = module.scrape_ec2.asg_name
}

output "alb_id" {
  description = "ALB ID"
  value = module.scrape_ec2.alb_id
}

output "alb_dns" {
  description = "ALB DNS Name"
  value = module.scrape_ec2.alb_dns
}

output "alb_zone_id" {
  description = "ALB canonical hosted zone ID (for Route 53 Alias record)"
  value = module.scrape_ec2.alb_zone_id
}

output "alb_lb_id" {
  description = "ALB Listener ID"
  value = module.scrape_ec2.alb_lb_id
}

output "alb_tg_id" {
  description = "ALB Target Group ID"
  value = module.scrape_ec2.alb_tg_id
}
