output "id" {
  value = aws_db_instance.postgres.id
}
output "db_password" {
  value = random_password.pg-random-password.result
}

output "db_name" {
  value = var.db_name
}

output "db_username" {
  value = var.username
}

output "pg_url" {
  value = aws_db_instance.postgres.endpoint
}

output "db_host" {
  value = aws_db_instance.postgres.address
}

output "random_password" {
  value = random_password.pg-random-password.result
}
