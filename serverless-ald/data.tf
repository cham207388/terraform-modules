# Data sources for account ID and region
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
