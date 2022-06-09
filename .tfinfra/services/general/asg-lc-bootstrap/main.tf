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
  security_groups             = var.security_groups
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
  vpc_zone_identifier  = var.vpc_subnet_ids

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

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
