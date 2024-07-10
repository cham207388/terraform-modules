variable "cidr_all" {
  default = "0.0.0.0/0"
}
variable "subnet_ids" {
  type = list(any)
}
variable "service_ipv4_cidr" {
  type    = string
  default = "172.20.0.0/16"
}
variable "endpoint_public_access" {
  type = bool
}

variable "name" {}

variable "tags" {
  type = map(any)
  default = {
    Name = "EKS Cluster"
  }
}