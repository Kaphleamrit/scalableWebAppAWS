resource "aws_launch_configuration" "app_launch_config" {
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  launch_configuration = aws_launch_configuration.app_launch_config.id
  vpc_zone_identifier  = aws_subnet.private[*].id
  min_size             = 2
  max_size             = 5
  desired_capacity     = 3
  target_group_arns    = [aws_lb_target_group.web_target_group.arn]
  health_check_type    = "ELB"
  health_check_grace_period = 300
}
