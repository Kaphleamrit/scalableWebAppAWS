resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  instance_class       = var.instance_class
  name                 = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot  = true
}
