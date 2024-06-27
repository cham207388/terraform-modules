variable "vpc_id" {}

variable "enabled_deletion_protection" {
  default = true
}

variable "db_name" {}

variable "db_username" {
  default = "admin"
}

variable "db_port" {
  default = "5432"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "protocol" {
  default = "tcp"
}

variable "db_instance_class" {}
variable "allocated_storage" {
  type = number
}
variable "subnet_ids" {}
variable "security_group_ids" {
  type = list(string)
}
