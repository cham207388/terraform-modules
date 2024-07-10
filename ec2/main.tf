resource "aws_instance" "ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  user_data                   = file("./ec2-user-data.sh")
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

resource "aws_instance" "instance" {
  iam_instance_profile = aws_iam_instance_profile.role_profile.name
}