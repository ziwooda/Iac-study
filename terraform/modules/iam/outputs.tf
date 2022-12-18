output "iam_user" {
  value = aws_iam_user.tf_iam_user.name
}

output "iam_group" {
  value = aws_iam_group.tf_iam_group.name
}

output "iam_role" {
  value = aws_iam_role.tf_iam_role.name
}

output "iam_policy" {
  value = aws_iam_policy.tf_policy.arn
}