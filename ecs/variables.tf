variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project/name prefix"
  type        = string
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "cpu" {
  description = "CPU"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory"
  type        = number
  default     = 512
}

variable "host_port" {
  description = "Host port"
  type        = number
}

variable "container_port" {
  description = "Container port"
  type        = number
}