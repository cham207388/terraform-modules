module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  # VPC Basic Details
  name            = "vpc-dev"
  cidr            = var.vpc_cidr
  azs             = local.selected_azs
  public_subnets  = local.public_subnet_cidrs
  private_subnets = local.private_subnet_cidrs

  # Database Subnets
  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  database_subnets                   = local.database_subnet_cidrs

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Type = "public-subnets"
    Name = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
    Name = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
    Name = "database-subnets"
  }

  tags = local.tags

  vpc_tags = {
    Name = "vpc-dev"
  }
}