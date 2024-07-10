output "keypair_id" {
  value = aws_key_pair.generated_key.key_pair_id
}

output "keypair_name" {
  value = aws_key_pair.generated_key.key_name
}