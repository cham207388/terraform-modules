# Example: Flexible DynamoDB Configuration
# This example shows how to use the serverless-ald module with custom attributes and GSIs

module "flexible_course_management" {
  source = "../"

  # Basic configuration
  function_name = "flexible-course-api"
  filename      = "./lambda/course-management.jar"
  handler      = "com.example.CourseHandler::handleRequest"
  table_name   = "flexible-courses-table"
  env          = "production"
  aws_region   = "us-west-2"
  api_name     = "Flexible Course Management API"
  api_description = "API for managing courses with flexible attributes"
  allow_origin = "https://example.com"
  account_id   = "123456789012"
  lambda_environment_variables = {
    TABLE_NAME = "flexible-courses-table"
    ENV        = "production"
  }
  stage_name = "prod"

  # Custom table attributes - users can define any attributes they need
  table_attributes = [
    {
      name = "id"
      type = "S"  # Primary key
    },
    {
      name = "name"
      type = "S"  # Course name
    },
    {
      name = "location"
      type = "S"  # Physical location or online
    },
    {
      name = "start_date"
      type = "S"  # ISO date string
    },
    {
      name = "end_date"
      type = "S"  # ISO date string
    },
    {
      name = "category"
      type = "S"  # Course category
    },
    {
      name = "price"
      type = "N"  # Price as number
    },
    {
      name = "is_active"
      type = "BOOL"  # Boolean flag
    },
    {
      name = "tags"
      type = "SS"  # String set for tags
    },
    {
      name = "metadata"
      type = "M"  # Map for additional metadata
    }
  ]

  # Global Secondary Indexes for flexible querying
  global_secondary_indexes = [
    # Query by name
    {
      name            = "name-index"
      hash_key        = "name"
      projection_type = "ALL"
    },
    # Query by location and date range
    {
      name            = "location-date-index"
      hash_key        = "location"
      range_key       = "start_date"
      projection_type = "INCLUDE"
      non_key_attributes = ["name", "category", "price", "is_active"]
    },
    # Query by category
    {
      name            = "category-index"
      hash_key        = "category"
      projection_type = "KEYS_ONLY"
    },
    # Query by price range
    {
      name            = "price-index"
      hash_key        = "price"
      projection_type = "INCLUDE"
      non_key_attributes = ["name", "location", "category"]
    }
  ]

  # Local Secondary Index for range queries on the same partition
  local_secondary_indexes = [
    {
      name            = "id-date-index"
      range_key       = "start_date"
      projection_type = "ALL"
    }
  ]

  # Billing configuration
  billing_mode = "PAY_PER_REQUEST"  # On-demand billing

  # Security features
  enable_point_in_time_recovery = true
  enable_encryption_at_rest     = true
}

# Outputs
output "api_url" {
  value = module.flexible_course_management.api_gateway_url
  description = "API Gateway URL"
}

output "table_name" {
  value = module.flexible_course_management.dynamodb_table_name
  description = "DynamoDB table name"
}

output "gsi_names" {
  value = module.flexible_course_management.dynamodb_global_secondary_index_names
  description = "Global Secondary Index names"
}

output "lsi_names" {
  value = module.flexible_course_management.dynamodb_local_secondary_index_names
  description = "Local Secondary Index names"
}
