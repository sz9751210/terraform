module "node_pool" {
  source             = "../../modules/nodepool"
  project            = "your-project-id"
  max_node_count     = 3
  min_node_count     = 0
  cluster_name       = "gke"
  cluster_zone       = "asia-east1-b"
  nodepool_name      = "default-pool"
  node_zone          = "asia-east1-b"
  node_version       = "1.27.3-gke.100"
  max_pod_num        = 110
  node_count         = 1
  initial_node_count = 0
  max_surge          = 1
  max_unavailable    = 0
  labels = {
    env = "dev"
  }
  machine_type = "e2-medium"
  disk_size_gb = 100
  disk_type    = "pd-standard"
}
