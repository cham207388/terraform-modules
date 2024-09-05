module "ec2_public_bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "bastion-instance"
  ami  = module.ami.id

  instance_type          = "t2.micro"
  key_name               = module.keypair.key_name
  monitoring             = true
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create Elastic IP for Bastion Host
resource "aws_eip" "bastion_eip" {
  depends_on = [module.vpc]
  instance   = module.ec2_public_bastion.id
  tags       = local.tags
}

resource "null_resource" "copy_ec2_keypair" {
  depends_on = [module.ec2_public_bastion]
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("${module.keypair.key_name}")
  }

  provisioner "file" {
    source      = module.keypair.key_name
    destination = "/tmp/${module.keypair.key_name}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/${module.keypair.key_name}"
    ]
  }

  provisioner "local-exec" {
    command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "${path.module}/"
  }
}