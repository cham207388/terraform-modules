# Serverless ALD Examples

This directory contains examples showing how to use the serverless-ald module with different DynamoDB configurations.

## Examples

### 1. Simple Custom Attributes (`simple-custom-attributes.tf`)

A basic example showing how to add custom attributes like `name`, `location`, and `date` to your DynamoDB table. This is perfect for users who just want to extend the default table with a few additional fields.

**Key Features:**
- Custom attributes: `id`, `name`, `location`, `date`
- One Global Secondary Index for querying by name
- Uses default settings for billing and security

### 2. Flexible DynamoDB Configuration (`flexible-dynamodb-example.tf`)

A comprehensive example showing advanced DynamoDB features including multiple data types, complex GSIs, and LSIs. This demonstrates the full flexibility of the module.

**Key Features:**
- Multiple data types: String (S), Number (N), Boolean (BOOL), String Set (SS), Map (M)
- Multiple Global Secondary Indexes for different query patterns
- Local Secondary Index for range queries
- Custom billing and security configurations

## Usage

1. Copy the example file that best fits your needs
2. Update the variables (function_name, filename, handler, etc.)
3. Customize the `table_attributes` and indexes as needed
4. Run `terraform init` and `terraform apply`

## Common Use Cases

### E-commerce Product Catalog
```hcl
table_attributes = [
  { name = "id", type = "S" },
  { name = "name", type = "S" },
  { name = "category", type = "S" },
  { name = "price", type = "N" },
  { name = "in_stock", type = "BOOL" },
  { name = "tags", type = "SS" }
]
```

### User Management System
```hcl
table_attributes = [
  { name = "user_id", type = "S" },
  { name = "email", type = "S" },
  { name = "created_at", type = "S" },
  { name = "is_active", type = "BOOL" },
  { name = "profile", type = "M" }
]
```

### Event Management
```hcl
table_attributes = [
  { name = "event_id", type = "S" },
  { name = "name", type = "S" },
  { name = "location", type = "S" },
  { name = "start_date", type = "S" },
  { name = "end_date", type = "S" },
  { name = "capacity", type = "N" }
]
```

## Tips

1. **Start Simple**: Begin with the simple example and add complexity as needed
2. **Plan Your Queries**: Design your GSIs based on your application's query patterns
3. **Use Appropriate Data Types**: Choose the right DynamoDB data type for each attribute
4. **Consider Costs**: More GSIs mean higher costs, so only create what you need
5. **Test Locally**: Use LocalStack or AWS SAM for local testing before deploying
