variable "db_name" { type = string }
variable "username" { type = string }
variable "password" { type = string }

variable "security_group_ids" {
  type = list(string)
}
variable "publicly_accessible" {
  type = bool
}

variable "deletion_protection" {
  default = false
}
variable "engine" {
  default = "postgres"
}
variable "maintenance_window" {
  default = "Sun:00:00-Sun:03:00"
}

variable "backup_window" {
  default = "03:00-06:00"
}
variable "delete_automated_backups" {
  default = true
}

variable "db_port" {
  default = "5432"
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

variable "allow_major_version_upgrade" {
  default = true
}
variable "multi_az" {
  default = true
}
variable "skip_final_snapshot" {
  default = true
}
