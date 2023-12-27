terraform {
  backend "gcs" {
    bucket  = "gcs-terraform"
    prefix  = "dev-bucket-state"
  }
}
