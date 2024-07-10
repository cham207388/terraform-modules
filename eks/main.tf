// this is the control plane: no worker node for now.
resource "aws_eks_cluster" "kubedemy" {
  name     = var.name
  role_arn = aws_iam_role.eks-kubedemy.arn

  vpc_config {
    subnet_ids             = var.subnet_ids
    endpoint_public_access = var.endpoint_public_access
    public_access_cidrs    = [var.cidr_all]
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service_ipv4_cidr
    ip_family         = "ipv4"
  }

  version = "1.29"

  tags = var.tags
}