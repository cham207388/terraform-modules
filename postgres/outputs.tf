output "db_password" {
  value = random_password.pg-random-password.result
}

output "db_name" {
  value = var.db_name
}

output "db_username" {
  value = var.db_username
}

output "pg_url" {
  value = aws_db_instance.postgres.endpoint
}

