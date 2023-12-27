module "brazil-platform" {
  source        = "../modules"
  project_id    = "your-project-id"
  region        = "asia-east1"
  bucket_name   = "dev-gcs-terraform"
  location      = "ASIA-EAST1"
  storage_class = "STANDARD"
}
