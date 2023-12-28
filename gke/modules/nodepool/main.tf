resource "google_container_node_pool" "node_pool" {

  cluster  = var.cluster_name
  location = var.cluster_zone

  name               = var.nodepool_name
  node_count         = var.node_count
  node_locations     = [var.node_zone]
  initial_node_count = var.initial_node_count
  version            = var.node_version
  max_pods_per_node  = var.max_pod_num

  autoscaling {
    max_node_count = var.max_node_count
    min_node_count = var.min_node_count
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  network_config {
    create_pod_range     = true
    enable_private_nodes = true
  }

  node_config {
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type
    image_type   = "COS_CONTAINERD"

    labels = var.labels

    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
    service_account = "default"

    shielded_instance_config {
      enable_integrity_monitoring = true
    }
  }

  upgrade_settings {
    max_surge       = var.max_surge
    max_unavailable = var.max_unavailable
  }
}
