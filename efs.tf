resource "aws_efs_file_system" "web_efs" {
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

resource "aws_efs_mount_target" "efs_mount" {
  count             = 3
  file_system_id    = aws_efs_file_system.web_efs.id
  subnet_id         = aws_subnet.private[count.index].id
  security_groups   = [aws_security_group.web_sg.id]
}
