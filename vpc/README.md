# VPC Terraform Module

This module creates a VPC with public and private subnets, Internet Gateway, and route tables.

## Features

- Creates a VPC with DNS support and hostnames enabled
- Creates an Internet Gateway attached to the VPC
- Creates 2 public subnets (us-east-1a and us-east-1b) with auto-assign public IP enabled
- Creates 2 private subnets (us-east-1a and us-east-1b)
- Creates a private route table and associates private subnets
- Configures default route to Internet Gateway for public subnets

## Usage

### From GitHub

To use this module from the GitHub repository, reference it as follows:

```hcl
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc"
  
  # Optional: Override default CIDR block
  cidr_block = "10.0.0.0/16"
  
  # Optional: Customize tags
  vpc_tags = {
    Name = "MyVPC"
  }
}
```

### Using a Specific Branch or Tag

```hcl
# Use a specific branch
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=main"
}

# Use a specific tag/version
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=v1.0.0"
}

# Use a specific commit
module "vpc" {
  source = "git::https://github.com/cham207388/terraform-modules.git//vpc?ref=abc123def"
}
```

### Using SSH (for private repositories)

```hcl
module "vpc" {
  source = "git::ssh://git@github.com/cham207388/terraform-modules.git//vpc"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr_block | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| vpc_tags | Tags to apply to the VPC | `map(any)` | `{ Name = "SAA-VPC" }` | no |
| igw_tags | Tags to apply to the Internet Gateway | `map(any)` | `{ Name = "SAA-IGW" }` | no |
| public_subnet_1a_tags | Tags to apply to public subnet in us-east-1a | `map(any)` | `{ Name = "SAA-Public-1A" }` | no |
| public_subnet_1b_tags | Tags to apply to public subnet in us-east-1b | `map(any)` | `{ Name = "SAA-Public-1B" }` | no |
| private_subnet_1a_tags | Tags to apply to private subnet in us-east-1a | `map(any)` | `{ Name = "SAA-Private-1A" }` | no |
| private_subnet_1b_tags | Tags to apply to private subnet in us-east-1b | `map(any)` | `{ Name = "SAA-Private-1B" }` | no |
| private_route_table_tags | Tags to apply to the private route table | `map(any)` | `{ Name = "SAA-Private-RT" }` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| vpc_cidr_block | The CIDR block of the VPC |
| vpc_arn | The ARN of the VPC |
| vpc_default_route_table_id | The ID of the default route table (used by public subnets) |
| internet_gateway_id | The ID of the Internet Gateway |
| public_subnet_ids | List of public subnet IDs |
| public_subnet_cidr_blocks | List of public subnet CIDR blocks |
| public_subnet_availability_zones | List of availability zones for public subnets |
| public_subnet_1a_id | The ID of the public subnet in us-east-1a |
| public_subnet_1b_id | The ID of the public subnet in us-east-1b |
| private_subnet_ids | List of private subnet IDs |
| private_subnet_cidr_blocks | List of private subnet CIDR blocks |
| private_subnet_availability_zones | List of availability zones for private subnets |
| private_subnet_1a_id | The ID of the private subnet in us-east-1a |
| private_subnet_1b_id | The ID of the private subnet in us-east-1b |
| private_route_table_id | The ID of the private route table |
| all_subnet_ids | List of all subnet IDs (public and private) |
| availability_zones | List of availability zones used |

## Resources Created

- 1 VPC
- 1 Internet Gateway
- 2 Public Subnets (us-east-1a, us-east-1b)
- 2 Private Subnets (us-east-1a, us-east-1b)
- 1 Private Route Table
- 2 Route Table Associations (for private subnets)
- 1 Route (default route to Internet Gateway)

## Example

See `example.tf` for a complete working example.

## Notes

- The subnet CIDR blocks and availability zones are currently hardcoded in the module
- Availability zones are set to `us-east-1a` and `us-east-1b`
- Subnet CIDRs: `10.0.1.0/24`, `10.0.2.0/24` (public), `10.0.3.0/24`, `10.0.4.0/24` (private)

## License

This module is provided as-is.

