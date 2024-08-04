resource "aws_dynamodb_table" "state_locking" {
  name         = var.dynamodb_table_name
  billing_mode = var.dynamodb_billing_mode
  hash_key     = "LockID" # See https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.bucket_encryption_key.arn
  }

  tags = var.tagging
}
