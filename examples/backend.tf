module "backendifier" {
  source = "../"

  # Team decided that "tf_backend" is too boring!
  bucket_name_suffix = "my-super-duper-project"
}

output "where_is_my_bucket" {
  description = "Where, precisely, IS by bucket?"
  value       = module.backend.bucket_name
}
