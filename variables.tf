variable "region" {
  description = "What AWS region do you want your backend to live in?"

  type    = string
  default = "us-west-2"
}

#KMS Variables

variable "kms_key_deletion_window" {
  description = "Number of days to retain deleted KMS keys for backup purposes."

  type    = number
  default = 10
}

variable "kms_key_rotation_enabled" {
  description = "Whether or not to enable KMS rotation. Almost always a good idea."

  type    = bool
  default = true
}

# S3 Bucket Variables

variable "bucket_name" {
  description = "The name of the bucket for your backend."

  type    = string
  default = "tf-backend"
}

variable "noncurrent_version_transitions" {
  description = "Specifies when noncurrent object versions transitions. See the aws_s3_bucket document for detail."

  type = list(object({
    days          = number
    storage_class = string
  }))

  default = [
    {
      days          = 30
      storage_class = "GLACIER"
    }
  ]
}

variable "noncurrent_version_expiration" {
  description = "Specifies when noncurrent object versions expire. See the aws_s3_bucket document for detail."

  type = object({
    days = number
  })

  default = null
}

variable "noncurrent_log_version_transitions" {
  description = "Specifies when noncurrent object versions transitions. See the aws_s3_bucket document for detail."

  type = list(object({
    days          = number
    storage_class = string
  }))

  default = [
    {
      days          = 90
      storage_class = "GLACIER"
    }
  ]
}

variable "noncurrent_log_version_expiration" {
  description = "Specifies when noncurrent object versions expire. See the aws_s3_bucket document for detail."

  type = object({
    days = number
  })

  default = null
}

# DynamoDB Variables

variable "dynamodb_table_name" {
  description = "Name for the locking table"

  type    = string
  default = "tf_state_lock"
}

variable "dynamodb_billing_mode" {
  description = <<-EOL
    The billing mode for the DynamoDB locking table. For low-volume (<50 runs/day), PAY_PER_REQUEST is considerably
    less exensive. Switch to PROVISIONED if you need autoscaling (niche).
  EOL

  type    = string
  default = "PAY_PER_REQUEST"
}
