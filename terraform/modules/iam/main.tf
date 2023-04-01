# iam user
resource "aws_iam_user" "tf_iam_user" {
  name = var.user_name
}

# data "aws_iam_user" "tf_iam_user" {
#   user_name = "camezii"
# }

# iam group
resource "aws_iam_group" "tf_iam_group" {
  name = var.group_name
}

resource "aws_iam_group_membership" "terraform" {
  name = aws_iam_group.tf_iam_group.name

  users = [
    aws_iam_user.tf_iam_user.name
    # data.aws_iam_user.tf_iam_user.user_name
  ]
  group = aws_iam_group.tf_iam_group.name
}

# AdministratorAccess IAM policy
data "aws_iam_policy" "admin_access" {
  name = "AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "iam_group_attach" {
  group      = aws_iam_group.tf_iam_group.name
  policy_arn = data.aws_iam_policy.admin_access.arn
}

resource "aws_iam_user_policy_attachment" "iam_user_attach" {
  user       = aws_iam_user.tf_iam_user.name
  policy_arn = data.aws_iam_policy.admin_access.arn
}

# resource "aws_iam_role" "tf_role" {
#   name = "TF_Role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid    = "policy to access AWS resources"
#         Action = ["sts:AssumeRole"]
#         Effect = "Allow"
#         Principal = { "AWS": "944371408142" }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "iam_role_attach" {
#   role       = aws_iam_role.tf_role.name
#   policy_arn = data.aws_iam_policy.admin_access.arn
# }
