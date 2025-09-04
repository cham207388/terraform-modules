resource "aws_security_group" "this" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.ingress
    to_port     = var.ingress
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }
  tags = {
    Name = var.name
  }
}