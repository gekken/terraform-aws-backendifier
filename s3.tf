# State Bucket

resource "aws_s3_bucket" "state_bucket" {
  #checkov:skip=CKV2_AWS_61:Deprecated, Handled in aws_s3_bucket_lifecycle_configuration
  #checkov:skip=CKV2_AWS_62:Handled in TF/Pipeline
  #checkov:skip=CKV_AWS_144:Don't see the point for terraform. if you want it, make more buckets in EU or something.
  bucket = var.custom_bucket_name != null ? var.custom_bucket_name : local.bucket_name

  tags = var.tagging
}

resource "aws_s3_bucket_policy" "s3_bucket_force_ssl" {
  bucket = aws_s3_bucket.state_bucket.id
  policy = data.aws_iam_policy_document.s3_bucket_force_ssl.json
}

resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "state_bucket_lifecycle" {
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    id     = "abort-failed-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
  rule {
    id     = "auto-archive"
    status = "Enabled"

    dynamic "noncurrent_version_transition" {
      for_each = var.noncurrent_version_transitions

      content {
        noncurrent_days = noncurrent_version_transition.value.days
        storage_class   = noncurrent_version_transition.value.storage_class
      }
    }

    dynamic "noncurrent_version_expiration" {
      for_each = var.noncurrent_version_expiration != null ? [var.noncurrent_version_expiration] : []

      content {
        noncurrent_days = noncurrent_version_expiration.value.days
      }
    }
  }
}

resource "aws_s3_bucket_logging" "state_bucket_logging" {
  bucket = aws_s3_bucket.state_bucket.id

  target_bucket = aws_s3_bucket.state_logging_bucket.id
  target_prefix = "tfstate/"
}

resource "aws_s3_bucket_ownership_controls" "state_bucket_ownership" {
  #checkov:skip=CKV2_AWS_65:This is unnecessary with IAM, no public, etc. what about several teams using one bucket in an Org?
  bucket = aws_s3_bucket.state_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "state_bucket_public_access_blocking" {
  bucket = aws_s3_bucket.state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket_encryption" {
  bucket = aws_s3_bucket.state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.bucket_encryption_key.key_id
      sse_algorithm     = "aws:kms"
    }
  }
}


# Logging Bucket

resource "aws_s3_bucket" "state_logging_bucket" {
  #checkov:skip=CKV_AWS_21:Logging Bucket versioning is unnecessary for logging bucket
  #checkov:skip=CKV2_AWS_61:Deprecated, Handled in aws_s3_bucket_lifecycle_configuration
  #checkov:skip=CKV2_AWS_62:Handled by pipeline/terraform
  #checkov:skip=CKV_AWS_144:No point in terraform.
  bucket = "${aws_s3_bucket.state_bucket.id}-logging"

  tags = var.tagging
}

resource "aws_s3_bucket_ownership_controls" "state_logging_bucket_ownership" {
  #checkov:skip=CKV2_AWS_65:This is to handle multi-account Orgs.
  bucket = aws_s3_bucket.state_logging_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "state_logging_bucket_public_access_blocking" {
  bucket = aws_s3_bucket.state_logging_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_logging_bucket_encryption" {
  bucket = aws_s3_bucket.state_logging_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.bucket_encryption_key.key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "state_logging_bucket_lifecycle" {
  #checkov:skip=CKV_AWS_300:If AWS is failing their own uploads, there are other issues.
  bucket = aws_s3_bucket.state_logging_bucket.id

  rule {
    id     = "auto-archive"
    status = "Enabled"

    dynamic "noncurrent_version_transition" {
      for_each = var.noncurrent_log_version_transitions

      content {
        noncurrent_days = noncurrent_version_transition.value.days
        storage_class   = noncurrent_version_transition.value.storage_class
      }
    }

    dynamic "noncurrent_version_expiration" {
      for_each = var.noncurrent_log_version_expiration != null ? [var.noncurrent_log_version_expiration] : []

      content {
        noncurrent_days = noncurrent_version_expiration.value.days
      }
    }
  }
}
