variable "vpc_id" {}

variable "enabled_deletion_protection" {
  default = true
}

variable "db_name" {}

variable "username" {
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
variable "identifier" {
  default = "database-1"
}
variable "engine_version" {
  default = "15.5"
}

variable "db_instance_class" {}
variable "allocated_storage" {
  type    = number
  default = 50
}
variable "subnet_ids" {}
variable "security_group_ids" {
  type = list(string)
}
variable "allow_major_version_upgrade" {
  type = bool
}
variable "multi_az" {
  type = bool
}
variable "publicly_accessible" {
  type = bool
}
