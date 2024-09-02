output "endpoint" {
  value = aws_eks_cluster.learning.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.learning.certificate_authority[0].data
}

output "key_pair" {
  description = "Name of the keypair to allow ssh"
  value       = module.keypair.key_id
}