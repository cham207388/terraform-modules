variable "function_name" {
  type = string
}

variable "filename" {
  type = string
}

variable "handler" {
  type = string
}

variable "table_name" {
  type = string
}

variable "env" {
  type = string
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "api_name" {
  type = string
}

variable "api_description" {
  type = string
}

variable "allow_origin" {
  type = string
} 

variable "account_id" {
  type = string
}