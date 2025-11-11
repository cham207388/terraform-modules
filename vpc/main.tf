# VPC
resource "aws_vpc" "saa_vpc" {
  cidr_block = var.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.vpc_tags
}

# Internet Gateway
resource "aws_internet_gateway" "saa_igw" {
  vpc_id = aws_vpc.saa_vpc.id

  tags = var.igw_tags
}

# Public Subnets
resource "aws_subnet" "saa_public_1a" {
  vpc_id                  = aws_vpc.saa_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = var.public_subnet_1a_tags
}

resource "aws_subnet" "saa_public_1b" {
  vpc_id                  = aws_vpc.saa_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = var.public_subnet_1b_tags
}

# Private Subnets
resource "aws_subnet" "saa_private_1a" {
  vpc_id            = aws_vpc.saa_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = var.private_subnet_1a_tags
}

resource "aws_subnet" "saa_private_1b" {
  vpc_id            = aws_vpc.saa_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = var.private_subnet_1b_tags
}

# Private Route Table
resource "aws_route_table" "saa_private_rt" {
  vpc_id = aws_vpc.saa_vpc.id

  tags = var.private_route_table_tags
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "saa_private_1a" {
  subnet_id      = aws_subnet.saa_private_1a.id
  route_table_id = aws_route_table.saa_private_rt.id
}

resource "aws_route_table_association" "saa_private_1b" {
  subnet_id      = aws_subnet.saa_private_1b.id
  route_table_id = aws_route_table.saa_private_rt.id
}

# Associate Internet Gateway with Public Route Table (default route table)
# The default route table is created automatically with the VPC
resource "aws_route" "saa_public_igw_route" {
  route_table_id         = aws_vpc.saa_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.saa_igw.id
}

