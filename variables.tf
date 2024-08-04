variable "region" {
  description = "What AWS region do you want your backend to live in?"

  type    = string
  default = "us-west-2"
}

variable "profile" {
  description = "The aws STS/SSO profile to use"

  type    = string
  default = "default"
}

variable "tagging" {
  description = "an optional map to hold tags see README.md > Tag Example"

  type     = map(string)
  default  = {}
  nullable = true
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

variable "custom_bucket_name" {
  description = "This is if you want to create a completely custom name. Remember, S3 bucket names _must_ be globally unique. Good luck!"
  type        = string
  default     = null
}

variable "bucket_name_suffix" {
  description = <<-EOL
    This module concatenates a prefix string using
    [`random_pet`](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet)
    to help ensure [globally-unique names](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingBucket.html)
  EOL

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
