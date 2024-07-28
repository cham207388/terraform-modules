output "id" {
  value = aws_db_instance.postgres.id
}

output "db_name" {
  value = var.db_name
}

output "db_username" {
  value = var.username
}

output "db_port" {
  value = aws_db_instance.postgres.port
}

output "pg_url" {
  value = aws_db_instance.postgres.endpoint
}

output "db_host" {
  value = aws_db_instance.postgres.address
}

output "db_instance_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "db_instance_id" {
  value = aws_db_instance.postgres.id
}