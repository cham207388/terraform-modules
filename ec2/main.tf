resource "aws_instance" "my_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  user_data                   = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f)</h1> > /var/www/html/index.html
              EOF
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  tags                        = var.tags
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.role_profile.id
}

resource "aws_iam_instance_profile" "role_profile" {
  name = "role_profile"
  role = aws_iam_role.ec2.name
}
