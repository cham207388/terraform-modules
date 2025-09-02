output "api_gateway_url" {
#   value = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.aws_region}.amazonaws.com/${aws_api_gateway_stage.dev.stage_name}"
#   description = "API Gateway URL"
  value = "http://localhost.localstack.cloud:4566/restapis/${aws_api_gateway_rest_api.api.id}/${aws_api_gateway_stage.dev.stage_name}/_user_request_/"
  description = "API Gateway URL (LocalStack)"
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

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.course_table.arn
  description = "DynamoDB Table ARN"
}

output "dynamodb_table_id" {
  value = aws_dynamodb_table.course_table.id
  description = "DynamoDB Table ID"
}

output "dynamodb_table_stream_arn" {
  value = aws_dynamodb_table.course_table.stream_arn
  description = "DynamoDB Table Stream ARN"
}

output "dynamodb_table_stream_label" {
  value = aws_dynamodb_table.course_table.stream_label
  description = "DynamoDB Table Stream Label"
}

output "dynamodb_global_secondary_index_names" {
  value = [for gsi in aws_dynamodb_table.course_table.global_secondary_index : gsi.name]
  description = "List of Global Secondary Index names"
}

output "dynamodb_local_secondary_index_names" {
  value = [for lsi in aws_dynamodb_table.course_table.local_secondary_index : lsi.name]
  description = "List of Local Secondary Index names"
}