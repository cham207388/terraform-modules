resource "aws_iam_role" "ec2" {
  name = "EC2_Role"

  assume_role_policy = file("ec2-policy.json")

  tags = {
    Name = "EC2 role"
  }
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-attachment" {
  role       = aws_iam_role.ec2.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}