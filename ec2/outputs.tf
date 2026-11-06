output "ec2_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.my_instance.id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.my_instance.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.my_instance.public_ip
}

output "ami_id" {
  description = "Amazon Linux 2023 AMI ID used for the instance"
  value       = data.aws_ami.amazon_linux_2023.id
}

output "key_name" {
  description = "Name of the generated SSH key pair"
  value       = aws_key_pair.ssh.key_name
}

output "private_key_path" {
  description = "Local path to the generated private key"
  value       = local_file.ssh_private_key.filename
}

output "security_group_id" {
  description = "Security group attached to the instance"
  value       = aws_security_group.this.id
}

output "subnet_id" {
  description = "Default VPC subnet used for the instance"
  value       = local.subnet_id
}

output "vpc_id" {
  description = "Default VPC ID"
  value       = data.aws_vpc.default.id
}
