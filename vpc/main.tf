resource "aws_vpc" "vpc-abc" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
}