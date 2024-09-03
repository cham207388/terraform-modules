// this is the control plane: no worker node for now.
resource "aws_eks_cluster" "learning" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_learning.arn

  vpc_config {
    subnet_ids             = aws_subnet.eks_subnet[*].id
    endpoint_public_access = true
    public_access_cidrs    = [var.cidr_all]
  }

  kubernetes_network_config {
    service_ipv4_cidr = "172.20.0.0/16"
    ip_family         = "ipv4"
  }

  version = "1.29"

  tags = {
    owner = "learning"
    Name  = "LearningK8s"
  }
}