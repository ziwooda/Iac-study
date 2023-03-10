# S3&Dynamodb settings for all resources

# S3 backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.env}-${var.user_alias}-terraform-remote-state"
}

resource "aws_s3_bucket_versioning" "tf_bucket_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "TerraformStateLock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
