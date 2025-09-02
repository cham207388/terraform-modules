# Example: Simple Custom Attributes
# This example shows how to add custom attributes like name, location, and date

module "simple_course_management" {
  source = "../"

  # Basic configuration
  function_name = "simple-course-api"
  filename      = "./lambda/course-management.jar"
  handler      = "com.example.CourseHandler::handleRequest"
  table_name   = "simple-courses-table"
  env          = "dev"
  aws_region   = "us-west-2"
  api_name     = "Simple Course Management API"
  api_description = "API for managing courses with custom attributes"
  allow_origin = "*"
  account_id   = "123456789012"
  lambda_environment_variables = {
    TABLE_NAME = "simple-courses-table"
    ENV        = "dev"
  }
  stage_name = "dev"

  # Custom table attributes - just add the attributes you need
  table_attributes = [
    {
      name = "id"
      type = "S"  # Primary key (required)
    },
    {
      name = "name"
      type = "S"  # Course name
    },
    {
      name = "location"
      type = "S"  # Course location
    },
    {
      name = "date"
      type = "S"  # Course date
    }
  ]

  # Optional: Add a GSI for querying by name
  global_secondary_indexes = [
    {
      name            = "name-index"
      hash_key        = "name"
      projection_type = "ALL"
    }
  ]

  # Use default settings for everything else
}

# Outputs
output "api_url" {
  value = module.simple_course_management.api_gateway_url
}

output "table_name" {
  value = module.simple_course_management.dynamodb_table_name
}
