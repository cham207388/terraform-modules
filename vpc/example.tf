# Example: Using the VPC Module from GitHub

# Configure the AWS Provider
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
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

# Output the VPC ID and other useful information
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

