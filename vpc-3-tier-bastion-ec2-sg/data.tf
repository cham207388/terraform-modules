data "aws_availability_zones" "available" {
  state = "available"
}

# Using slice() to select the first n availability zones: 2
locals {
  selected_azs = slice(data.aws_availability_zones.available.names, 0, var.number_of_subnets)

  # Dynamically allocate CIDR blocks for public, private, and database subnets
  public_subnet_cidrs   = [for i in range(length(local.selected_azs)) : cidrsubnet("10.0.0.0/16", 8, i + 1)]
  private_subnet_cidrs  = [for i in range(length(local.selected_azs)) : cidrsubnet("10.0.100.0/16", 8, i)]
  database_subnet_cidrs = [for i in range(length(local.selected_azs)) : cidrsubnet("10.0.200.0/16", 8, i)]
}