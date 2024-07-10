output "ec2_id" {
  value = aws_instance.ec2.id
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}