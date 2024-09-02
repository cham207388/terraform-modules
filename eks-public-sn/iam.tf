// eks cluster role and attachment
resource "aws_iam_role" "eks_learning" {
  name = "learning_EKS_Cluster_Role"

  assume_role_policy = file("./policy/eks-policy.json")

  tags = {
    tag-key = "EKS role"
  }
}

# This policy is required for the EKS service to manage your Kubernetes cluster.
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_learning.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# This policy allows EKS to manage VPC resources, such as elastic network interfaces, on your behalf.
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_learning.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

// node group role and attachment
resource "aws_iam_role" "node_group_learning" {
  name = "learning_EKS_Managed_Nodegroup_Role"

  assume_role_policy = file("./policy/node-group-policy.json")

  tags = {
    tag-key = "Node Group role"
  }
}

# node group policy attachment
# This policy allows Amazon EKS worker nodes to connect to Amazon EKS Clusters.
resource "aws_iam_role_policy_attachment" "node_group_eks_worker_node_policy" {
  role       = aws_iam_role.node_group_learning.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Provides read_only access to Amazon EC2 Container Registry repositories.
resource "aws_iam_role_policy_attachment" "node_group_ec2_container_registry_read_only" {
  role       = aws_iam_role.node_group_learning.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "node_group_eks_cni_policy" {
  role       = aws_iam_role.node_group_learning.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
