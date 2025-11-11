# How to Use the VPC Module from GitHub

This guide shows you how to use the VPC module from the GitHub repository `cham207388/terraform-modules` in your Terraform configurations.

## Module Source

The module is hosted at: `https://github.com/cham207388/terraform-modules`

To reference only the `vpc` folder (subdirectory), use the following syntax:

```hcl
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc"
  
  # Optional: Specify a specific branch, tag, or commit
  # source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=main"
  # source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=v1.0.0"
  # source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=abc123def"
}
```

## Complete Usage Example

Here's a complete example of how to use this module:

```hcl
# provider.tf
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

# main.tf
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc"
  
  # Optional: Override default CIDR block
  # Note: Currently the module hardcodes the CIDR in main.tf, 
  # but you can still pass variables for tags
  
  # Customize tags
  vpc_tags = {
    Name        = "MyCustomVPC"
    Environment = "production"
    Project     = "my-project"
  }
  
  igw_tags = {
    Name = "MyCustomIGW"
  }
  
  public_subnet_1a_tags = {
    Name = "MyPublicSubnet-1A"
  }
  
  public_subnet_1b_tags = {
    Name = "MyPublicSubnet-1B"
  }
  
  private_subnet_1a_tags = {
    Name = "MyPrivateSubnet-1A"
  }
  
  private_subnet_1b_tags = {
    Name = "MyPrivateSubnet-1B"
  }
  
  private_route_table_tags = {
    Name = "MyPrivateRouteTable"
  }
}

# outputs.tf
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}
```

## Module Reference Options

### Using a Specific Branch
```hcl
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=main"
}
```

### Using a Specific Tag/Version
```hcl
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=v1.0.0"
}
```

### Using a Specific Commit SHA
```hcl
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=abc123def456789"
}
```

## Available Input Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `cidr_block` | `string` | `"10.0.0.0/16"` | VPC CIDR block (currently not used in main.tf) |
| `vpc_tags` | `map(any)` | `{ Name = "SAA-VPC" }` | Tags for the VPC |
| `igw_tags` | `map(any)` | `{ Name = "SAA-IGW" }` | Tags for the Internet Gateway |
| `public_subnet_1a_tags` | `map(any)` | `{ Name = "SAA-Public-1A" }` | Tags for public subnet in us-east-1a |
| `public_subnet_1b_tags` | `map(any)` | `{ Name = "SAA-Public-1B" }` | Tags for public subnet in us-east-1b |
| `private_subnet_1a_tags` | `map(any)` | `{ Name = "SAA-Private-1A" }` | Tags for private subnet in us-east-1a |
| `private_subnet_1b_tags` | `map(any)` | `{ Name = "SAA-Private-1B" }` | Tags for private subnet in us-east-1b |
| `private_route_table_tags` | `map(any)` | `{ Name = "SAA-Private-RT" }` | Tags for the private route table |

## Available Outputs

| Output | Description |
|--------|-------------|
| `vpc_id` | The ID of the VPC |
| `vpc_cidr_block` | The CIDR block of the VPC |
| `vpc_arn` | The ARN of the VPC |
| `vpc_default_route_table_id` | The ID of the default route table (used by public subnets) |
| `internet_gateway_id` | The ID of the Internet Gateway |
| `public_subnet_ids` | List of public subnet IDs |
| `public_subnet_cidr_blocks` | List of public subnet CIDR blocks |
| `public_subnet_availability_zones` | List of availability zones for public subnets |
| `public_subnet_1a_id` | The ID of the public subnet in us-east-1a |
| `public_subnet_1b_id` | The ID of the public subnet in us-east-1b |
| `private_subnet_ids` | List of private subnet IDs |
| `private_subnet_cidr_blocks` | List of private subnet CIDR blocks |
| `private_subnet_availability_zones` | List of availability zones for private subnets |
| `private_subnet_1a_id` | The ID of the private subnet in us-east-1a |
| `private_subnet_1b_id` | The ID of the private subnet in us-east-1b |
| `private_route_table_id` | The ID of the private route table |
| `all_subnet_ids` | List of all subnet IDs (public and private) |
| `availability_zones` | List of availability zones used |

## Resources Created

This module creates the following AWS resources:

1. **VPC** - Virtual Private Cloud with DNS support enabled
2. **Internet Gateway** - Attached to the VPC for internet access
3. **Public Subnets** (2) - In us-east-1a and us-east-1b with auto-assign public IP enabled
4. **Private Subnets** (2) - In us-east-1a and us-east-1b
5. **Route Table** - Private route table for private subnets
6. **Route Table Associations** - Associates private subnets with the private route table
7. **Route** - Default route (0.0.0.0/0) to Internet Gateway for public subnets

## Important Notes

1. **Hardcoded Values**: The module currently has hardcoded values for:
   - VPC CIDR: `10.0.0.0/16`
   - Subnet CIDRs: `10.0.1.0/24`, `10.0.2.0/24`, `10.0.3.0/24`, `10.0.4.0/24`
   - Availability Zones: `us-east-1a` and `us-east-1b`
   
   Consider updating the module to make these configurable via variables.

2. **Region**: The availability zones are hardcoded to `us-east-1a` and `us-east-1b`. If you're deploying to a different region, you'll need to modify the module or create a fork.

3. **Initialization**: When using a Git source, run `terraform init` to download the module:
   ```bash
   terraform init
   ```

4. **Authentication**: If the repository is private, you may need to configure Git credentials or use SSH:
   ```hcl
   source = "git::ssh://git@github.com/cham207388/terraform-modules.git//vpc"
   ```

## Example: Using Module Outputs with Other Resources

```hcl
# Use the VPC module
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc"
}

# Create a security group using the VPC ID
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Security group for web servers"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 instance in a public subnet
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with your AMI
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_1a_id

  tags = {
    Name = "WebServer"
  }
}
```

