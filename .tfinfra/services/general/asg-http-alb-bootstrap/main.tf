# MODULES/FEATURES USED IN FEATURE

# RESOURCE
resource "aws_launch_configuration" "lc" {
  # REQUIRED VARIABLES
  image_id                    = var.ami
  instance_type               = var.instance_type

  # OPTIONAL VARIABLES
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.aws_key_name
  name_prefix                 = "${var.asg_name}-"
  security_groups             = var.asg_security_groups
  user_data                   = var.userdata

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    delete_on_termination = var.delete_on_termination
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
  }
}

resource "aws_autoscaling_group" "asg" {
  # REQUIRED VARIABLES
  max_size             = var.asg_max_capacity
  min_size             = var.asg_min_capacity

  # OPTIONAL VARIABLES
  desired_capacity     = var.asg_desired_capacity
  force_delete         = var.force_delete
  launch_configuration = aws_launch_configuration.lc.name
  name                 = var.asg_name
  target_group_arns    = [aws_lb_target_group.alb_tg.arn]
  vpc_zone_identifier  = var.asg_vpc_subnet_ids

  lifecycle {
    create_before_destroy = true
    ignore_changes = [load_balancers, target_group_arns]
  }

  depends_on = [
    aws_lb_target_group.alb_tg,
    aws_launch_configuration.lc
  ]

  # TAGS
  dynamic "tag" {
    for_each = local.instance_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# Create ALB :
resource "aws_lb" "alb" {
  # REQUIRED VARIABLES
  name               = var.alb_name
  security_groups    = var.alb_security_groups

  # OPTIONAL VARIABLES
  idle_timeout       = var.alb_idle_timeout  # 60
  internal           = var.alb_internal  # false
  load_balancer_type = "application"
  subnets            = var.alb_vpc_subnet_ids

  # TAGS
  dynamic "tag" {
    for_each = local.alb_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_lb_target_group" "alb_tg" {
  # REQUIRED VARIABLES
  name     = var.alb_tg_name
  vpc_id   = var.vpc_id

  # OPTIONAL VARIABLES
  port     = "80"
  protocol = "HTTP"  

  health_check {
    healthy_threshold   = var.alb_health_healthy_threshold
    interval            = var.alb_health_interval
    path                = var.alb_health_path
    port                = var.alb_health_port
    timeout             = var.alb_health_timeout
    unhealthy_threshold = var.alb_health_unhealthy_threshold
  }

  # TAGS
  dynamic "tag" {
    for_each = local.alb_tg_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    type             = "forward"
  }
}
