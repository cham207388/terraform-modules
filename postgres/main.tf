resource "aws_db_instance" "postgres" {
  allocated_storage      = var.allocated_storage
  instance_class         = var.db_instance_class
  engine                 = "postgres"
  engine_version         = "15.5"
  identifier             = var.db_name
  db_name                = var.db_name
  username               = var.db_username
  password               = random_password.pg-random-password.result
  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = var.security_group_ids

  skip_final_snapshot                 = true
  publicly_accessible                 = false
  iam_database_authentication_enabled = false
  deletion_protection                 = false

  maintenance_window       = "Sun:00:00-Sun:03:00"
  backup_retention_period  = 1
  delete_automated_backups = true
  backup_window            = "03:00-06:00"
}

resource "random_password" "pg-random-password" {
  length  = 12
  special = false
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres-subnet-group"
  subnet_ids = var.subnet_ids
}

output "db_instance_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.postgres.id
}