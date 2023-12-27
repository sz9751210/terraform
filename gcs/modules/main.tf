resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  public_access_prevention    = "enforced"
  force_destroy               = true
  uniform_bucket_level_access = true
  versioning {
    enabled = false
  }
}
