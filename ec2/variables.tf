variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "associate_public_ip_address" {
  description = "Associate a public IP so SSH and SSM can reach the instance in the default VPC"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "Name of the generated EC2 key pair used for SSH"
  type        = string
  default     = "ec2-ssh-key"
}

variable "ssh_ingress_cidr_blocks" {
  description = "IPv4 CIDR blocks allowed to SSH to the instance. Restrict this in non-lab environments."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags applied to created resources"
  type        = map(string)
  default = {
    Name = "EC2"
  }
}
