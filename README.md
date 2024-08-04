# Backendifier
This repo creates a reasonably secure, best-practices Terraform Backend in AWS S3 for small to medium teams.

It is slightly opinionated, but most decsions are easily supported and can obviously be overridden.

## Examples
see [examples](./examples/)

> Note - The only variable I'd change every time is the `dynamodb_table_name` - "tf-backend" is a little too generic.

### Tagging Example

You can add an arbitrary map of tags to all objects:

terraform.tfvars:
```hcl

tagging = {
    waffles = "tasty"
    owner = "Bob in Accounting"
    env:Dev = true
}
```

The module will also add `terraform = true` to all resources. For reasons.

This is so individual items can be independentaly tagged, but I recomment putting them in `default_tags` in your `terraform.tf`/`provider.tf` (however you do your provider config).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.9.0, <2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.60.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.60.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.state_locking](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/dynamodb_table) | resource |
| [aws_kms_alias.bucket_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.bucket_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/kms_key) | resource |
| [aws_s3_bucket.state_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.state_logging_bucket](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.state_bucket_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.state_logging_bucket_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.state_bucket_logging](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.state_bucket_ownership](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.state_logging_bucket_ownership](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.s3_bucket_force_ssl](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.state_bucket_public_access_blocking](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.state_logging_bucket_public_access_blocking](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.state_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.state_logging_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.state_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/resources/s3_bucket_versioning) | resource |
| [random_pet.rando](https://registry.terraform.io/providers/hashicorp/random/3.6.2/docs/resources/pet) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.s3_bucket_force_ssl](https://registry.terraform.io/providers/hashicorp/aws/5.60.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name_suffix"></a> [bucket\_name\_suffix](#input\_bucket\_name\_suffix) | This module concatenates a prefix string using<br>[`random_pet`](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet)<br>to help ensure [globally-unique names](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingBucket.html) | `string` | `"tf-backend"` | no |
| <a name="input_custom_bucket_name"></a> [custom\_bucket\_name](#input\_custom\_bucket\_name) | This is if you want to create a completely custom name. Remember, S3 bucket names _must_ be globally unique. Good luck! | `string` | `null` | no |
| <a name="input_dynamodb_billing_mode"></a> [dynamodb\_billing\_mode](#input\_dynamodb\_billing\_mode) | The billing mode for the DynamoDB locking table. For low-volume (<50 runs/day), PAY\_PER\_REQUEST is considerably<br>less exensive. Switch to PROVISIONED if you need autoscaling (niche). | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | Name for the locking table | `string` | `"tf_state_lock"` | no |
| <a name="input_kms_key_deletion_window"></a> [kms\_key\_deletion\_window](#input\_kms\_key\_deletion\_window) | Number of days to retain deleted KMS keys for backup purposes. | `number` | `10` | no |
| <a name="input_kms_key_rotation_enabled"></a> [kms\_key\_rotation\_enabled](#input\_kms\_key\_rotation\_enabled) | Whether or not to enable KMS rotation. Almost always a good idea. | `bool` | `true` | no |
| <a name="input_noncurrent_log_version_expiration"></a> [noncurrent\_log\_version\_expiration](#input\_noncurrent\_log\_version\_expiration) | Specifies when noncurrent object versions expire. See the aws\_s3\_bucket document for detail. | <pre>object({<br>    days = number<br>  })</pre> | `null` | no |
| <a name="input_noncurrent_log_version_transitions"></a> [noncurrent\_log\_version\_transitions](#input\_noncurrent\_log\_version\_transitions) | Specifies when noncurrent object versions transitions. See the aws\_s3\_bucket document for detail. | <pre>list(object({<br>    days          = number<br>    storage_class = string<br>  }))</pre> | <pre>[<br>  {<br>    "days": 90,<br>    "storage_class": "GLACIER"<br>  }<br>]</pre> | no |
| <a name="input_noncurrent_version_expiration"></a> [noncurrent\_version\_expiration](#input\_noncurrent\_version\_expiration) | Specifies when noncurrent object versions expire. See the aws\_s3\_bucket document for detail. | <pre>object({<br>    days = number<br>  })</pre> | `null` | no |
| <a name="input_noncurrent_version_transitions"></a> [noncurrent\_version\_transitions](#input\_noncurrent\_version\_transitions) | Specifies when noncurrent object versions transitions. See the aws\_s3\_bucket document for detail. | <pre>list(object({<br>    days          = number<br>    storage_class = string<br>  }))</pre> | <pre>[<br>  {<br>    "days": 30,<br>    "storage_class": "GLACIER"<br>  }<br>]</pre> | no |
| <a name="input_profile"></a> [profile](#input\_profile) | The aws STS/SSO profile to use | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | What AWS region do you want your backend to live in? | `string` | `"us-west-2"` | no |
| <a name="input_tagging"></a> [tagging](#input\_tagging) | an optional map to hold tags see README.md > Tag Example | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the bucket |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
