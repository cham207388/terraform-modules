resource "aws_instance" "my_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  user_data                   = file("${path.module}/ec2-user-data.sh")
  # iam_instance_profile        = aws_iam_instance_profile.role_profile.id
  tags = var.tags
}


# resource "aws_iam_instance_profile" "role_profile" {
#   name = "ec2-profile"
#   role = aws_iam_role.this.name
# }