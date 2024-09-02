# Step 1: Enable OIDC Provider for EKS
# # Data source to get the EKS cluster OIDC provider
data "aws_eks_cluster" "eks_cluster" {
  name       = var.cluster_name
  depends_on = [aws_eks_cluster.learning]
}

data "tls_certificate" "default" {
  url        = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  depends_on = [aws_eks_cluster.learning]
}

resource "aws_iam_openid_connect_provider" "default" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.default.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

# Step 2: Create an IAM Role
resource "aws_iam_role" "eks_service_account" {
  name = "${var.namespace}-eks-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid    = ""
      Effect = "Allow",
      Principal = {
        Federated = aws_iam_openid_connect_provider.default.arn
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "${aws_iam_openid_connect_provider.default.url}:sub" = "system:serviceaccount:default:my-service-account"
          "${aws_iam_openid_connect_provider.default.url}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
  tags = {
    "Name"        = "${var.cluster_name}-irsa-role-${var.namespace}"
    "Environment" = var.cluster_name
  }
}

# Example of being able to interact with AWS service
resource "aws_iam_role_policy" "default" {
  name = "eks-irsa-policy"
  role = aws_iam_role.eks_service_account.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      Resource = "*"
    }]
  })
}

# Step 3: Create a Kubernetes Service Account
resource "kubernetes_service_account" "example" {
  metadata {
    name      = "my-service-account"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks_service_account.arn
    }
  }
}