resource "aws_iam_role" "ssm" {
  name               = "${var.key_name}-ssm-role"
  assume_role_policy = file("${path.module}/ec2-policy.json")

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm" {
  name = "${var.key_name}-ssm-profile"
  role = aws_iam_role.ssm.name

  tags = var.tags
}
