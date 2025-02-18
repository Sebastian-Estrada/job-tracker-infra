resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  instance_class       = var.instance_class
  engine              = var.engine
  engine_version      = var.engine_version
  db_name             = var.db_name
  username            = var.username
  password            = var.password
  parameter_group_name = var.parameter_group_name
  multi_az           = var.multi_az
  storage_encrypted  = var.storage_encrypted
  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection

  publicly_accessible  = true

  vpc_security_group_ids = var.vpc_security_group_ids

  db_subnet_group_name = aws_db_subnet_group.default.name
  tags = var.tags
}
