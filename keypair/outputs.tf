output "key-pair-id" {
  value = aws_key_pair.generated_key.key_pair_id
}

output "key-pair-name" {
  value = aws_key_pair.generated_key.key_name
}