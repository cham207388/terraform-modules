
variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_tags" {
  type = map(any)
  default = {
    Name = "SAA-VPC"
  }
}

variable "igw_tags" {
  type = map(any)
  default = {
    Name = "SAA-IGW"
  }
}

variable "public_subnet_1a_tags" {
  type = map(any)
  default = {
    Name = "SAA-Public-1A"
  }
}

variable "public_subnet_1b_tags" {
  type = map(any)
  default = {
    Name = "SAA-Public-1B"
  }
}

variable "private_subnet_1a_tags" {
  type = map(any)
  default = {
    Name = "SAA-Private-1A"
  }
}

variable "private_subnet_1b_tags" {
  type = map(any)
  default = {
    Name = "SAA-Private-1B"
  }
}

variable "private_route_table_tags" {
  type = map(any)
  default = {
    Name = "SAA-Private-RT"
  }
}