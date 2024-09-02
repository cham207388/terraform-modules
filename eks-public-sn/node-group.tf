resource "aws_eks_node_group" "application_managed_workers" {
  cluster_name    = aws_eks_cluster.learning.name
  node_group_name = "application-managed"
  node_role_arn   = aws_iam_role.node_group_learning.arn
  subnet_ids      = aws_subnet.eks_subnet[*].id

  instance_types = ["t3.medium"]
  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"

  labels = {
    "node.kubernetes.io/scope" = "application"
  }

  remote_access {
    ec2_ssh_key               = module.keypair.key_name
    source_security_group_ids = [aws_security_group.eks_node_sg.id]
  }

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = "Application Managed"
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_group_eks_worker_node_policy,
    aws_iam_role_policy_attachment.node_group_ec2_container_registry_read_only,
    aws_iam_role_policy_attachment.node_group_eks_cni_policy
  ]
}