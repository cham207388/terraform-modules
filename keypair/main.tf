resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key-name
  public_key = tls_private_key.rsa.public_key_openssh
}

# Save the private key locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.filename
}