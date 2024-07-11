resource "aws_iam_role" "this" {
  name = "EC2 role tf"

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
    Name = "EC2 role tf"
  }
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-attachment" {
  role       = aws_iam_role.this.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}