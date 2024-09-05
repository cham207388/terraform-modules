module "keypair" {
  source   = "git@github.com:cham207388/terraform-modules.git//keypair?ref=main"
  filename = "${path.module}/${var.filename}.pem"
}

module "ami" {
  source = "git@github.com:cham207388/terraform-modules.git//ami?ref=main"
}

output "id" {
  value = module.ami.id
}