module "cluster" {
  source                    = "../modules"
  project_id                = "your-project-id"
  db_version                = "6.0"
  provider_name             = "GCP"
  instance_size             = "M10"
  node_count                = 3
  compute_max_instance_size = "M40"
  compute_min_instance_size = "M10"
  clusters = {
    "atlas-cluster" = {
      region_name = "EASTERN_ASIA_PACIFIC"
      tags = [
        {
          key   = "environment"
          value = "dev"
        }
      ]
    }
  }
}
