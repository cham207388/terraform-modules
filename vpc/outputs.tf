# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.saa_vpc.id
}

# Internet Gateway Outputs
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.saa_igw.id
}

output "public_subnet_1a_id" {
  description = "The ID of the public subnet in us-east-1a"
  value       = aws_subnet.saa_public_1a.id
}

output "public_subnet_1b_id" {
  description = "The ID of the public subnet in us-east-1b"
  value       = aws_subnet.saa_public_1b.id
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

output "availability_zones" {
  description = "List of availability zones used"
  value       = ["us-east-1a", "us-east-1b"]
}
