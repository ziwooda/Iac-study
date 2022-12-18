resource "aws_iam_group" "tf_iam_group" {
  name = "${var.group_name}"
}

resource "aws_iam_group_membership" "terraform" {
  name = aws_iam_group.tf_iam_group.name

  users = [
    aws_iam_user.tf_iam_user.name
  ]
  group = aws_iam_group.tf_iam_group.name
}

resource "aws_iam_group_policy_attachment" "iam_group_attach" {
  group      = aws_iam_group.tf_iam_group.name
  policy_arn = aws_iam_policy.tf_policy.arn
}