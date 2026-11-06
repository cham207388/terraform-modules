resource "aws_security_group" "this" {
  name        = "${var.key_name}-sg"
  description = "SSH inbound and egress for SSM Agent and package updates"
  vpc_id      = data.aws_vpc.default.id

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each = toset(var.ssh_ingress_cidr_blocks)

  security_group_id = aws_security_group.this.id
  cidr_ipv4         = each.value
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "SSH"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all egress so SSM Agent can reach Systems Manager"
}