resource "aws_dynamodb_table" "course_table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "${var.table_name}Table"
    Env  = var.env
  }
}
