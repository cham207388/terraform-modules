# API Gateway (REST API)
resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = var.api_description
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{proxy+}"
}

# API Methods with Integration Timeout
resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.course_management.invoke_arn
  timeout_milliseconds    = 29000 # API Gateway max timeout
}

# Root resource configuration
resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_rest_api.api.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.course_management.invoke_arn
  timeout_milliseconds    = 29000
}

# Deployment with proper stage management
resource "aws_api_gateway_deployment" "api" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
    aws_lambda_permission.allow_apigw
  ]

  rest_api_id = aws_api_gateway_rest_api.api.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "dev" {
  stage_name    = var.stage_name
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api.id

  # Enable detailed logging
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn
    format = jsonencode({
      requestId        = "$context.requestId",
      ip               = "$context.identity.sourceIp",
      requestTime      = "$context.requestTime",
      httpMethod       = "$context.httpMethod",
      routeKey         = "$context.routeKey",
      status           = "$context.status",
      protocol         = "$context.protocol",
      responseLength   = "$context.responseLength",
      integrationError = "$context.integration.error"
    })
  }
}

# CloudWatch Log Group for API Gateway
resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/api-gateway/${replace(aws_api_gateway_rest_api.api.name, " ", "-")}"
  retention_in_days = 7
}
