output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.public_ip
}

output "private_key_path" {
  description = "Local path to the generated SSH private key"
  value       = module.ec2.private_key_path
}

output "ssh_command" {
  description = "SSH command to connect to the EC2 instance"
  value       = "ssh -i ${module.ec2.private_key_path} ec2-user@${module.ec2.public_ip}"
}
