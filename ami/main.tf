data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "owner-id"
    values = ["137112412989"] # Amazon's AWS account ID
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }

  owners = ["amazon"]

  tags = {
    "ami-type" = "free-tier"
  }
}
