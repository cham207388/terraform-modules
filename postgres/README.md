# PostgreSQL Usage

```hcl
module "postgres" {
  source              = "github.com/cham207388/terraform-modules//postgres"
  db_name             = var.db_name
  username            = var.db_username
  password            = random_password.pg_password.result
  allocated_storage   = 20
  db_instance_class   = var.db_instance_class
  security_group_ids  = [var.sg_id]
  subnet_ids          = [var.subnet_a_id, var.subnet_b_id]
  publicly_accessible = true
}
```
