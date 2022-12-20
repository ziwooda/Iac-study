# # backend for network resources

# terraform {
#   backend "s3" {
#     bucket = "${var.env}-${var.user_name}-terraform-remote-state"
#     key = "modules/network/terraform.tfstate"
#     region = "ap-northeast-2"
#     encrypt = true
#     dynamodb-table = "terraform-lock"
#   }
# }