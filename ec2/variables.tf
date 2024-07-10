variable "ami" {
  default = "ami-06c68f701d8090592"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "vpc_security_group_ids" {
  type = list(any)
}
variable "user_data" {}
variable "associate_public_ip_address" {
  type = bool
}
variable "subnet_id" {}
variable "key_name" {}
variable "tags" {
  type = map(any)
  default = {
    Name = "EC2"
  }
}