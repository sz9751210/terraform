resource "mongodbatlas_advanced_cluster" "database_deployment" {
  for_each                       = var.clusters
  project_id                     = var.project_id
  name                           = each.key
  cluster_type                   = "REPLICASET"
  mongo_db_major_version         = var.db_version
  backup_enabled                 = true
  pit_enabled                    = true
  termination_protection_enabled = true

  replication_specs {
    num_shards = 1
    region_configs {
      electable_specs {
        instance_size = var.instance_size
        node_count    = var.node_count
      }
      provider_name = var.provider_name
      priority      = 7
      region_name   = each.value.region_name
      auto_scaling {
        disk_gb_enabled            = true
        compute_enabled            = true
        compute_scale_down_enabled = true
        compute_max_instance_size  = var.compute_max_instance_size
        compute_min_instance_size  = var.compute_min_instance_size
      }
    }
  }

  advanced_configuration {
    javascript_enabled           = true
    minimum_enabled_tls_protocol = "TLS1_2"
  }

  dynamic "tags" {
    for_each = each.value.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}