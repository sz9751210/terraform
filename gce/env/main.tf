module "general-instance" {
  source         = "../modules"
  region         = "asia-east1"
  machine_type   = "e2-medium"
  image          = "centos-cloud/centos-7"
  boot_disk_type = "pd-standard"
  boot_disk_size = 20
  vpc_name       = "default"
  subnet_name    = "default"
  resource_tags  = ["dev", "gce"]
  labels = {
    "env"  = "dev"
    "proj" = "gce"
  }
  servers = {
    "gce-1" = { ip = "10.128.0.45", zone = "asia-east1-a" }
    "gce-2" = { ip = "10.128.0.50", zone = "asia-east1-b" }
  }
}
