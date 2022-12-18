resource "aws_iam_policy" "tf_policy" {
  name        = "AdminAccessPolicy"
  path        = "/"
  description = "a policy to access all AWS resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "*",
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}