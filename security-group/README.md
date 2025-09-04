# Security Group Usage

```hcl
module "security_group" {
  source = "github.com/cham207388/terraform-modules//security-group"
  vpc_id = var.vpc_id
  ingress = var.ingress
  name = var.name
  cidr_blocks = var.cidr_blocks
}
```