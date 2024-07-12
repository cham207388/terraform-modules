output "key_id" {
  value = aws_key_pair.generated_key.key_pair_id
}

output "key_name" {
  value = aws_key_pair.generated_key.key_name
}