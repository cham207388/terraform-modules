variable "vpc_id" {}
variable "ingress" {
  type = number
}
variable "name" {}
variable "cidr_blocks" {
  type = list(string)
}