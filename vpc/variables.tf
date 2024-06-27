variable "vpc_id" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "tags" {
  default = {
    Name        = "dev-vpc"
    Environment = "dev"
  }
}