resource "aws_vpc" "main" {
  cidr_block = var.cidr-block
  tags       = var.tags
}