# Input Variables
# AWS Region
variable "region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-2"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "dev"
}

variable "number_of_subnets" {
  description = "The number of subnets"
  type        = number
  default     = 2
}

variable "vpc_cidr" {
  description = "The VPC cidr block"
  type        = string
  default     = "10.0.0.0/16"
}