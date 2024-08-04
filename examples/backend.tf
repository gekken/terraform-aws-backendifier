module "backendifier" {
  source  = "gekken/backendifier/aws"
  version = "1.1.1"

  # Team decided that "tf_backend" is too boring!
  bucket_name_suffix = "my-super-duper-project"
}

output "where_is_my_bucket" {
  description = "Where, precisely, IS by bucket?"
  value       = module.backendifier.bucket_name
}
