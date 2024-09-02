variable "region" {
  description = "aws region"
}

variable "cluster_name" {
  default     = "learning-cluster"
  description = "eks cluster name"
}

variable "namespace" {
  default     = "default"
  description = "eks cluster namespace"
}

variable "filename" {
  default     = "eks-key"
  description = "name of keypair"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
}

variable "cidr_all" {
  description = "from anywhere"
  default     = "0.0.0.0/0"
}

variable "enable_dns_hostnames" {
  description = "enable dns hostnames to make it public"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "enable dns hostnames to make it public"
  type        = bool
  default     = true
}

variable "subnet_count" {
  description = "number of subnets"
  type        = number
  default     = 2
}