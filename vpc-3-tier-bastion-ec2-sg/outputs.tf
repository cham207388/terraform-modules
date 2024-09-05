output "azs" {
  value = slice(data.aws_availability_zones.available.names, 0, 2)
}

output "public_subnet_cidrs" {
  value = local.public_subnet_cidrs
}
output "private_subnet_cidrs" {
  value = local.private_subnet_cidrs
}
output "database_subnet_cidrs" {
  value = local.database_subnet_cidrs
}

output "key_name" {
  value = module.keypair.key_name
}