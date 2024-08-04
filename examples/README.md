# Basic Backendifier Example
This examples directory shows a very basic way to use the backendifier module.

## Usage

### Making the backend

#### Requirements:

* [AWS CLI set up correctly](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) with credentials [saved in a safe manner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).
* [Terraform](https://terraform.io)

First, create a repo named something like `backend_creator`, using [Terraform best practices](https://bomars.org) (or not, it's your code).

inside this repo, create a .tf file with the following content

```hcl
module "backendifier" {
  source  = "gekken/backendifier/aws"
  version = "1.1.0"

  # Team decided that "tf_backend" is too boring!
  bucket_name_suffix = "my-super-duper-project"
}

output "where_is_my_bucket" {
  description = "Where, precisely, IS by bucket?"
  value       = module.backendifier.bucket_name
}
```

Then run `terraform init` to install the module, `terraform plan` to make sure everything looks right, and `terraform apply` to create you brand-spanking-new backend.

### Using the backend in other modules
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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.9.0, <2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.60.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backendifier"></a> [backendifier](#module\_backendifier) | gekken/backendifier/aws | 1.1.1 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_where_is_my_bucket"></a> [where\_is\_my\_bucket](#output\_where\_is\_my\_bucket) | Where, precisely, IS by bucket? |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
