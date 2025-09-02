resource "aws_lambda_function" "course_management" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = 512
  timeout       = 300
  role          = aws_iam_role.lambda_exec_role.arn

  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_iam_role_policy_attachment.lambda_dynamodb_crud_attach
  ]

  environment {
    variables = var.lambda_environment_variables
  }
}

resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.course_management.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
