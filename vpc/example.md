# VPC Example

```hcl
# Example: Using the VPC Module from GitHub

# Configure the AWS Provider
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

# Use the VPC module from GitHub
# The //vpc syntax tells Terraform to use only the vpc subdirectory
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc"
  
  # Optional: Override the default CIDR block
  cidr_block = "10.0.0.0/16"
  
  # Optional: Customize tags
  vpc_tags = {
    Name        = "MyVPC"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
  
  igw_tags = {
    Name = "MyIGW"
  }
  
  public_subnet_1a_tags = {
    Name = "Public-1A"
  }
  
  public_subnet_1b_tags = {
    Name = "Public-1B"
  }
  
  private_subnet_1a_tags = {
    Name = "Private-1A"
  }
  
  private_subnet_1b_tags = {
    Name = "Private-1B"
  }
  
  private_route_table_tags = {
    Name = "Private-RT"
  }
}

# ============================================
# VPC Outputs
# ============================================
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_default_route_table_id" {
  description = "The ID of the default route table (used by public subnets)"
  value       = module.vpc.vpc_default_route_table_id
}

# ============================================
# Internet Gateway Outputs
# ============================================
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

# ============================================
# Public Subnet Outputs
# ============================================
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "public_subnet_cidr_blocks" {
  description = "List of public subnet CIDR blocks"
  value       = module.vpc.public_subnet_cidr_blocks
}

output "public_subnet_availability_zones" {
  description = "List of availability zones for public subnets"
  value       = module.vpc.public_subnet_availability_zones
}

output "public_subnet_1a_id" {
  description = "The ID of the public subnet in us-east-1a"
  value       = module.vpc.public_subnet_1a_id
}

output "public_subnet_1b_id" {
  description = "The ID of the public subnet in us-east-1b"
  value       = module.vpc.public_subnet_1b_id
}

# ============================================
# Private Subnet Outputs
# ============================================
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "private_subnet_cidr_blocks" {
  description = "List of private subnet CIDR blocks"
  value       = module.vpc.private_subnet_cidr_blocks
}

output "private_subnet_availability_zones" {
  description = "List of availability zones for private subnets"
  value       = module.vpc.private_subnet_availability_zones
}

output "private_subnet_1a_id" {
  description = "The ID of the private subnet in us-east-1a"
  value       = module.vpc.private_subnet_1a_id
}

output "private_subnet_1b_id" {
  description = "The ID of the private subnet in us-east-1b"
  value       = module.vpc.private_subnet_1b_id
}

# ============================================
# Route Table Outputs
# ============================================
output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = module.vpc.private_route_table_id
}

# ============================================
# Combined Outputs for Convenience
# ============================================
output "all_subnet_ids" {
  description = "List of all subnet IDs (public and private)"
  value       = module.vpc.all_subnet_ids
}

output "availability_zones" {
  description = "List of availability zones used"
  value       = module.vpc.availability_zones
}

```