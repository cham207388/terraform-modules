
variable "cidr-block" {
  default = "10.0.0.0/16"
}

variable "tags" {
  default = {
    Name        = "dev-vpc"
    Environment = "dev"
  }
}