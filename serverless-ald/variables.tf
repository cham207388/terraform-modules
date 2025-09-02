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

variable "lambda_environment_variables" {
  type = map(string)
}

variable "stage_name" {
  type = string
}

variable "runtime" {
  type = string
  default = "java21"
}

# DynamoDB Configuration Variables
variable "table_attributes" {
  description = "List of attributes for the DynamoDB table. Each attribute should have name and type (S, N, B, BOOL, NULL, SS, NS, BS, L, M)"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "id"
      type = "S"
    }
  ]
  validation {
    condition = alltrue([
      for attr in var.table_attributes : contains(["S", "N", "B", "BOOL", "NULL", "SS", "NS", "BS", "L", "M"], attr.type)
    ])
    error_message = "Attribute type must be one of: S, N, B, BOOL, NULL, SS, NS, BS, L, M."
  }
}

variable "global_secondary_indexes" {
  description = "List of Global Secondary Indexes for the DynamoDB table"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
    non_key_attributes = optional(list(string), [])
  }))
  default = []
  validation {
    condition = alltrue([
      for gsi in var.global_secondary_indexes : contains(["ALL", "KEYS_ONLY", "INCLUDE"], gsi.projection_type)
    ])
    error_message = "Projection type must be one of: ALL, KEYS_ONLY, INCLUDE."
  }
}

variable "local_secondary_indexes" {
  description = "List of Local Secondary Indexes for the DynamoDB table"
  type = list(object({
    name            = string
    range_key       = string
    projection_type = string
    non_key_attributes = optional(list(string), [])
  }))
  default = []
  validation {
    condition = alltrue([
      for lsi in var.local_secondary_indexes : contains(["ALL", "KEYS_ONLY", "INCLUDE"], lsi.projection_type)
    ])
    error_message = "Projection type must be one of: ALL, KEYS_ONLY, INCLUDE."
  }
}

variable "billing_mode" {
  description = "DynamoDB billing mode. Can be PROVISIONED or PAY_PER_REQUEST"
  type = string
  default = "PAY_PER_REQUEST"
  validation {
    condition = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "Billing mode must be either PROVISIONED or PAY_PER_REQUEST."
  }
}

variable "read_capacity" {
  description = "Number of read capacity units for the table (only used when billing_mode is PROVISIONED)"
  type = number
  default = 5
}

variable "write_capacity" {
  description = "Number of write capacity units for the table (only used when billing_mode is PROVISIONED)"
  type = number
  default = 5
}

variable "enable_point_in_time_recovery" {
  description = "Enable point-in-time recovery for the DynamoDB table"
  type = bool
  default = true
}

variable "enable_encryption_at_rest" {
  description = "Enable encryption at rest for the DynamoDB table"
  type = bool
  default = true
}