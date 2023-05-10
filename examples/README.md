# Basic Backendifier Example
This examples directory shows a very basic way to use the backendifier module.

## Usage
TODO: Write up how to source from Terraform Registry

Once you've run this module, your other module(s) can immediately begin to use the backend by placing the bucket name in your `provider.tf`/`terraform.tf` (or wherever you want, it's your code!), like this:

```hcl
terraform {
  backend "s3" {
    bucket = "fun-quail-my-super-duper-project"
    key    = "env/product/tf_state/"
    region = "us-west-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.66.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
```
> **_NOTE_**
>
> If you are using workspaces (and you should) please be familiar with how TF [does default workspace paths](https://developer.hashicorp.com/terraform/language/settings/backends/s3#workspace_key_prefix)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.4.0, <1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.66.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backendifier"></a> [backendifier](#module\_backendifier) | ../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_where_is_my_bucket"></a> [where\_is\_my\_bucket](#output\_where\_is\_my\_bucket) | Where, precisely, IS by bucket? |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
