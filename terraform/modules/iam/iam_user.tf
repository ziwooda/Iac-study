resource "aws_iam_user" "tf_iam_user" {
    name = "${var.user_name}"
}

resource "aws_iam_user_policy_attachment" "iam_user_attach" {
  user       = aws_iam_user.tf_iam_user.name
  policy_arn = aws_iam_policy.tf_policy.arn
}