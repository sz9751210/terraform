terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "1.12.2"
    }
  }
}

provider "mongodbatlas" {
  public_key = var.mongodb_atlas_public_key
  private_key  = var.mongodb_atlas_private_key
}
