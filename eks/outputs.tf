output "ec2_id" {
  value = aws_instance.ec2.id
}

output "public-ip" {
  value = aws_instance.ec2.public_ip
}
