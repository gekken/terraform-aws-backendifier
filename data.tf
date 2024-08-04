data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "s3_bucket_force_ssl" {
  statement {
    sid     = "S3TFBucketOnlyAllowTLS"
    actions = ["S3:*"]
    effect  = "Deny"
    resources = [
      aws_s3_bucket.state_bucket.arn,
      "${aws_s3_bucket.state_bucket.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
