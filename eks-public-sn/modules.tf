
module "keypair" {
  source   = "git@github.com:cham207388/terraform-modules.git//keypair?ref=main"
  filename = "${path.module}/${var.filename}.pem"
}
