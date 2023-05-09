locals {
  bucket_name = "${random_pet.rando.id}-${var.bucket_name}"
}
