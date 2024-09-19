resource "aws_launch_configuration" "this" {
  name          = var.name
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [var.security_group_id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnets
  launch_configuration = aws_launch_configuration.this.id
  target_group_arns    = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}
