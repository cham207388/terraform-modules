resource "aws_iam_role" "ec2" {
  name = "EC2_Role"

  assume_role_policy = jsonencode(
    {
      Version : "2012-10-17",
      Statement : [{
        Action : "sts:AssumeRole",
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com"
        }
        }
      ]
  })

  tags = {
    Name = "EC2 role"
  }
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-attachment" {
  role       = aws_iam_role.ec2.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}