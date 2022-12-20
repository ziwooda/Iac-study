# # backend for iam resources

# terraform {
#   backend "aws_s3_bucket_versioning" {
#     bucket = "${var.env}-${var.user_name}-terraform-remote-state"
#     key = "modules/iam/terraform.tfstate"
#     region = "ap-northeast-2"
#     encrypt = true
#     dynamodb-table = "terraform-lock"
#   }
# }