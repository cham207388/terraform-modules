resource "aws_db_instance" "postgres" {
  allocated_storage      = var.allocated_storage
  instance_class         = var.db_instance_class
  engine                 = var.engine
  engine_version         = var.engine_version
  identifier             = var.identifier
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = var.security_group_ids

  skip_final_snapshot                 = var.skip_final_snapshot
  publicly_accessible                 = var.publicly_accessible
  iam_database_authentication_enabled = false
  deletion_protection                 = var.deletion_protection

  allow_major_version_upgrade = var.allow_major_version_upgrade
  multi_az                    = var.multi_az

  maintenance_window       = var.maintenance_window
  backup_retention_period  = 1
  delete_automated_backups = var.delete_automated_backups
  backup_window            = var.backup_window
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres-subnet-group"
  subnet_ids = var.subnet_ids
}
