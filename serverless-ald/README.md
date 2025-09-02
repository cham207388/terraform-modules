# Serverless ALD Terraform Module

This Terraform module creates a complete serverless architecture with API Gateway, Lambda function, and DynamoDB table for course management applications.

## Features

- **API Gateway**: REST API with proxy integration and CORS support
- **Lambda Function**: Java 21 runtime with configurable memory and timeout
- **DynamoDB Table**: Flexible table configuration with custom attributes and indexes
  - Custom attributes with any DynamoDB data type (S, N, B, BOOL, etc.)
  - Global Secondary Indexes (GSI) for flexible querying patterns
  - Local Secondary Indexes (LSI) for range key queries
  - Configurable billing mode (PAY_PER_REQUEST or PROVISIONED)
  - Point-in-time recovery and encryption at rest
- **IAM Roles**: Least privilege access policies for Lambda execution
- **CloudWatch Logging**: Comprehensive logging for API Gateway and Lambda
- **CORS Support**: Configurable CORS headers for web applications

## Usage

### Basic Example

```hcl
module "serverless_ald" {
  source = "github.com/cham207388/terraform-modules//serverless-ald"

  # Required variables
  function_name    = "course-management-api"
  filename         = "./lambda/course-management.jar"
  handler         = "com.example.CourseHandler::handleRequest"
  table_name      = "courses-table"
  env             = "production"
  aws_region      = "us-west-2"
  api_name        = "Course Management API"
  api_description = "API for managing courses and curriculum"
  allow_origin    = "https://example.com"
}
```

### Complete Example with Custom DynamoDB Attributes and GSIs

```hcl
module "serverless_ald" {
  source = "github.com/cham207388/terraform-modules//serverless-ald"

  # Lambda configuration
  function_name = "course-management-api"
  filename      = "./lambda/course-management.jar"
  handler      = "com.example.CourseHandler::handleRequest"
  
  # DynamoDB configuration with custom attributes and GSIs
  table_name = "courses-table"
  table_attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "name"
      type = "S"
    },
    {
      name = "location"
      type = "S"
    },
    {
      name = "date"
      type = "S"
    },
    {
      name = "category"
      type = "S"
    },
    {
      name = "price"
      type = "N"
    }
  ]
  
  # Global Secondary Indexes for flexible querying
  global_secondary_indexes = [
    {
      name            = "name-index"
      hash_key        = "name"
      projection_type = "ALL"
    },
    {
      name            = "location-date-index"
      hash_key        = "location"
      range_key       = "date"
      projection_type = "INCLUDE"
      non_key_attributes = ["name", "category", "price"]
    },
    {
      name            = "category-index"
      hash_key        = "category"
      projection_type = "KEYS_ONLY"
    }
  ]
  
  # Local Secondary Index (optional)
  local_secondary_indexes = [
    {
      name            = "id-date-index"
      range_key       = "date"
      projection_type = "ALL"
    }
  ]
  
  # Billing configuration
  billing_mode = "PAY_PER_REQUEST"  # or "PROVISIONED"
  # read_capacity  = 5  # only needed for PROVISIONED
  # write_capacity = 5  # only needed for PROVISIONED
  
  # Security features
  enable_point_in_time_recovery = true
  enable_encryption_at_rest     = true
  
  # Environment and region
  env        = "production"
  aws_region = "us-west-2"
  
  # API Gateway configuration
  api_name        = "Course Management API"
  api_description = "API for managing courses and curriculum"
  allow_origin    = "https://example.com"
}

# Outputs
output "api_gateway_url" {
  value = module.serverless_ald.api_gateway_url
}

output "lambda_function_arn" {
  value = module.serverless_ald.lambda_function_arn
}

output "dynamodb_table_name" {
  value = module.serverless_ald.dynamodb_table_name
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.0 |

## Dependencies

This module uses the following external modules:
- `squidfunk/api-gateway-enable-cors/aws` (version 0.3.3) for CORS configuration

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| function_name | Name of the Lambda function | `string` | n/a | yes |
| filename | Path to the Lambda function JAR file | `string` | n/a | yes |
| handler | Lambda function handler (e.g., "com.example.Handler::handleRequest") | `string` | n/a | yes |
| table_name | Name of the DynamoDB table | `string` | n/a | yes |
| env | Environment name (e.g., "dev", "staging", "production") | `string` | n/a | yes |
| aws_region | AWS region where resources will be created | `string` | n/a | yes |
| api_name | Name of the API Gateway | `string` | n/a | yes |
| api_description | Description of the API Gateway | `string` | n/a | yes |
| allow_origin | CORS allowed origin (e.g., "https://example.com" or "*") | `string` | n/a | yes |
| account_id | AWS Account ID | `string` | n/a | yes |
| lambda_environment_variables | Environment variables for Lambda function | `map(string)` | n/a | yes |
| stage_name | API Gateway stage name | `string` | n/a | yes |
| runtime | Lambda runtime | `string` | `"java21"` | no |
| table_attributes | List of attributes for the DynamoDB table | `list(object({name=string, type=string}))` | `[{name="id", type="S"}]` | no |
| global_secondary_indexes | List of Global Secondary Indexes | `list(object({name=string, hash_key=string, range_key=optional(string), projection_type=string, non_key_attributes=optional(list(string))}))` | `[]` | no |
| local_secondary_indexes | List of Local Secondary Indexes | `list(object({name=string, range_key=string, projection_type=string, non_key_attributes=optional(list(string))}))` | `[]` | no |
| billing_mode | DynamoDB billing mode (PROVISIONED or PAY_PER_REQUEST) | `string` | `"PAY_PER_REQUEST"` | no |
| read_capacity | Read capacity units (only for PROVISIONED billing) | `number` | `5` | no |
| write_capacity | Write capacity units (only for PROVISIONED billing) | `number` | `5` | no |
| enable_point_in_time_recovery | Enable point-in-time recovery | `bool` | `true` | no |
| enable_encryption_at_rest | Enable encryption at rest | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| api_gateway_url | URL of the deployed API Gateway |
| api_gateway_id | ID of the API Gateway |
| api_gateway_execution_arn | Execution ARN of the API Gateway |
| lambda_function_arn | ARN of the Lambda function |
| lambda_function_name | Name of the Lambda function |
| dynamodb_table_name | Name of the DynamoDB table |
| dynamodb_table_arn | ARN of the DynamoDB table |
| dynamodb_table_id | ID of the DynamoDB table |
| dynamodb_table_stream_arn | Stream ARN of the DynamoDB table |
| dynamodb_table_stream_label | Stream label of the DynamoDB table |
| dynamodb_global_secondary_index_names | List of Global Secondary Index names |
| dynamodb_local_secondary_index_names | List of Local Secondary Index names |

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   API Gateway  │───▶│   Lambda Function│───▶│   DynamoDB      │
│   (REST API)   │    │   (Java 21)      │    │   Table         │
│   + CORS       │    │   + IAM Role     │    │   + IAM Policy  │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   CloudWatch    │    │   Lambda Perm    │    │   Data Sources  │
│   Logs          │    │   (API Gateway)  │    │   (Account/Region)│
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

## Module Structure

The module consists of the following Terraform files:
- **`main.tf`** - Main module configuration (if exists)
- **`api-gateway.tf`** - API Gateway resources with CORS and proxy integration
- **`lambda.tf`** - Lambda function and permissions
- **`dynamodb.tf`** - DynamoDB table configuration
- **`iam.tf`** - IAM roles and policies
- **`data.tf`** - Data sources for account ID and region
- **`outputs.tf`** - Module outputs
- **`variables.tf`** - Input variable definitions

## Lambda Function Requirements

Your Lambda function should:

1. **Handler Signature**: Implement the handler method specified in the `handler` variable
2. **JAR File**: Be packaged as a JAR file with all dependencies included
3. **Response Format**: Return responses compatible with API Gateway proxy integration

### Example Java Handler

```java
package com.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;

public class CourseHandler implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {
    
    @Override
    public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent input, Context context) {
        // Your business logic here
        
        return new APIGatewayProxyResponseEvent()
            .withStatusCode(200)
            .withBody("{\"message\": \"Success\"}")
            .withHeaders(Map.of("Content-Type", "application/json"));
    }
}
```

## DynamoDB Configuration

The module provides flexible DynamoDB table configuration to support various use cases:

### Table Attributes

Define custom attributes for your table:

```hcl
table_attributes = [
  {
    name = "id"
    type = "S"  # String
  },
  {
    name = "name"
    type = "S"  # String
  },
  {
    name = "price"
    type = "N"  # Number
  },
  {
    name = "is_active"
    type = "BOOL"  # Boolean
  }
]
```

**Supported Data Types:**
- `S` - String
- `N` - Number
- `B` - Binary
- `BOOL` - Boolean
- `NULL` - Null
- `SS` - String Set
- `NS` - Number Set
- `BS` - Binary Set
- `L` - List
- `M` - Map

### Global Secondary Indexes (GSI)

Create GSIs for flexible querying patterns:

```hcl
global_secondary_indexes = [
  {
    name            = "name-index"
    hash_key        = "name"
    projection_type = "ALL"  # Include all attributes
  },
  {
    name            = "location-date-index"
    hash_key        = "location"
    range_key       = "date"
    projection_type = "INCLUDE"
    non_key_attributes = ["name", "category", "price"]
  },
  {
    name            = "category-index"
    hash_key        = "category"
    projection_type = "KEYS_ONLY"  # Only key attributes
  }
]
```

**Projection Types:**
- `ALL` - All table attributes
- `KEYS_ONLY` - Only key attributes
- `INCLUDE` - Key attributes + specified non-key attributes

### Local Secondary Indexes (LSI)

Create LSIs for range key queries on the same partition key:

```hcl
local_secondary_indexes = [
  {
    name            = "id-date-index"
    range_key       = "date"
    projection_type = "ALL"
  }
]
```

### Billing Configuration

Choose between on-demand or provisioned billing:

```hcl
# On-demand billing (default)
billing_mode = "PAY_PER_REQUEST"

# Provisioned billing
billing_mode = "PROVISIONED"
read_capacity  = 10
write_capacity = 5
```

## API Endpoints

The module creates a proxy integration that routes all requests to your Lambda function:

- **Base URL**: `https://{api-id}.execute-api.{region}.amazonaws.com/prod/`
- **Proxy Path**: `/{proxy+}` - routes all paths to your Lambda function
- **Root Path**: `/` - also routes to your Lambda function
- **Methods**: GET, POST, PUT, DELETE, PATCH, OPTIONS (all supported)
- **Stage**: Automatically deployed to `prod` stage

## CORS Configuration

The module automatically configures CORS with:
- Configurable allowed origin
- Standard headers (Content-Type, Authorization, etc.)
- All common HTTP methods
- Credentials support enabled

## Security

- **IAM Roles**: Least privilege access policies
- **Lambda Permissions**: Only API Gateway can invoke the function
- **DynamoDB Access**: Limited to specific table operations
- **CORS**: Configurable origin restrictions
- **Data Sources**: Automatically retrieves current account ID and region for secure resource naming

## Monitoring and Logging

- **CloudWatch Logs**: Automatic logging for both API Gateway and Lambda
- **Access Logs**: Detailed API Gateway request/response logging
- **Lambda Logs**: Standard Lambda execution logs

## Cost Optimization

- **DynamoDB**: Pay-per-request billing (no provisioned capacity)
- **Lambda**: Pay only for actual execution time
- **API Gateway**: Pay per request and data transfer

## Troubleshooting

### Common Issues

1. **Lambda Permission Error**: Ensure the `aws_lambda_permission` resource is created before API Gateway deployment
2. **CORS Issues**: Verify the `allow_origin` variable is set correctly
3. **Timeout Errors**: Lambda timeout is set to 300 seconds (5 minutes)


### Important Notes

- **Lambda Permission**: The module automatically creates the necessary Lambda permission for API Gateway integration
- **CORS Module**: Uses the `squidfunk/api-gateway-enable-cors/aws` module for proper CORS configuration
- **API Gateway URL**: The output provides the complete URL including the stage name (e.g., `/prod`)

### Debugging

- Check CloudWatch logs for both API Gateway and Lambda
- Verify IAM permissions are correctly attached
- Ensure the JAR file path is correct and accessible

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This module is licensed under the MIT License.
