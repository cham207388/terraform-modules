# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.saa_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.saa_vpc.cidr_block
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.saa_vpc.arn
}

output "vpc_default_route_table_id" {
  description = "The ID of the default route table (used by public subnets)"
  value       = aws_vpc.saa_vpc.default_route_table_id
}

# Internet Gateway Outputs
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.saa_igw.id
}

# Public Subnet Outputs
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.saa_public_1a.id, aws_subnet.saa_public_1b.id]
}

output "public_subnet_cidr_blocks" {
  description = "List of public subnet CIDR blocks"
  value       = [aws_subnet.saa_public_1a.cidr_block, aws_subnet.saa_public_1b.cidr_block]
}

output "public_subnet_availability_zones" {
  description = "List of availability zones for public subnets"
  value       = [aws_subnet.saa_public_1a.availability_zone, aws_subnet.saa_public_1b.availability_zone]
}

output "public_subnet_1a_id" {
  description = "The ID of the public subnet in us-east-1a"
  value       = aws_subnet.saa_public_1a.id
}

output "public_subnet_1b_id" {
  description = "The ID of the public subnet in us-east-1b"
  value       = aws_subnet.saa_public_1b.id
}

# Private Subnet Outputs
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [aws_subnet.saa_private_1a.id, aws_subnet.saa_private_1b.id]
}

output "private_subnet_cidr_blocks" {
  description = "List of private subnet CIDR blocks"
  value       = [aws_subnet.saa_private_1a.cidr_block, aws_subnet.saa_private_1b.cidr_block]
}

output "private_subnet_availability_zones" {
  description = "List of availability zones for private subnets"
  value       = [aws_subnet.saa_private_1a.availability_zone, aws_subnet.saa_private_1b.availability_zone]
}

output "private_subnet_1a_id" {
  description = "The ID of the private subnet in us-east-1a"
  value       = aws_subnet.saa_private_1a.id
}

output "private_subnet_1b_id" {
  description = "The ID of the private subnet in us-east-1b"
  value       = aws_subnet.saa_private_1b.id
}

# Route Table Outputs
output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.saa_private_rt.id
}

# Combined Outputs for Convenience
output "all_subnet_ids" {
  description = "List of all subnet IDs (public and private)"
  value       = concat([aws_subnet.saa_public_1a.id, aws_subnet.saa_public_1b.id], [aws_subnet.saa_private_1a.id, aws_subnet.saa_private_1b.id])
}

output "availability_zones" {
  description = "List of availability zones used"
  value       = ["us-east-1a", "us-east-1b"]
}
