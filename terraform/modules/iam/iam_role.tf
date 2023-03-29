resource "aws_iam_role" "tf_iam_role" {
  name = "tf-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = { "AWS": "944371408142" }
      },
    ]
  })
}

# resource "aws_iam_role_policy" "tf_role_policy" {
#   name = "AdminRolePolicy"
#   role = aws_iam_role.tf_iam_role.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "*",
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

resource "aws_iam_role_policy_attachment" "iam_role_attach" {
  role       = aws_iam_role.tf_iam_role.name
  policy_arn = aws_iam_policy.tf_policy.arn
}