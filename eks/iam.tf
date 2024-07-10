// eks cluster role and attachment
resource "aws_iam_role" "eks-kubedemy" {
  name = "Kubedemy_EKS_Cluster_Role"

  assume_role_policy = file("./eks-policy.json")

  tags = {
    Name = "EKS role"
  }
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-attachment" {
  role       = aws_iam_role.eks-kubedemy.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}