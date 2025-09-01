output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${data.aws_region.current.id}.amazonaws.com/${aws_api_gateway_stage.prod.stage_name}"
  description = "API Gateway URL"
}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.api.id
  description = "API Gateway ID"
}

output "api_gateway_execution_arn" {
  value = aws_api_gateway_rest_api.api.execution_arn
  description = "API Gateway Execution ARN"
}

output "lambda_function_arn" {
  value = aws_lambda_function.course_management.arn
  description = "Lambda Function ARN"
}

output "lambda_function_name" {
  value = aws_lambda_function.course_management.function_name
  description = "Lambda Function Name"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.course_table.name
  description = "DynamoDB Table Name"
}