module "service_region_ip" {
  source         = "../modules"
  project_region = "asia-east1"
  addresses = [
    {
      name         = "service-region-ip"
      address_type = "EXTERNAL"
      region       = "asia-east1"
    }
  ]
}
