resource "aws_kms_key" "bucket_encryption_key" {
  description = "TF backend bucket encryption key"

  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = var.kms_key_deletion_window
  enable_key_rotation     = var.kms_key_rotation_enabled

  policy = jsonencode({
    Version = "2012-10-17"
    ID      = "Enable IAM permissions from this account"
    Statement = [
      {
        SID    = "Allow root all actions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      }
    ]
    }
  )

  tags = var.tagging
}

resource "aws_kms_alias" "bucket_encryption_key_alias" {
  name          = "alias/${local.bucket_name}-key"
  target_key_id = aws_kms_key.bucket_encryption_key.key_id
}
