resource "google_container_cluster" "gke_cluster" {

  ##### 叢集基本資料 #####
  name     = var.cluster_name
  location = var.zone

  # 控制層版本 -> 發布版本
  release_channel {
    channel = "UNSPECIFIED"
  }

  # node_version = var.node_version
  min_master_version       = var.node_version
  initial_node_count       = 1
  remove_default_node_pool = true
  ##### 節點集區 #####
  #### default-pool ####
  # 啟用叢集自動配制器
  cluster_autoscaling {
    enabled = false
  }
  #### 節點數 ####
  node_config {
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type
    image_type   = "COS_CONTAINERD"

    labels = var.labels

    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    #### 安全性 ####
    # 存取權範圍
    oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]

    # 身份識別資訊預設值  
    service_account = "default"

    # 受防護的選項 -> 啟用完整性監控
    shielded_instance_config {
      enable_integrity_monitoring = true
    }
  }

  ##### 自動化 #####
  # 通知 -> 啟用通知
  notification_config {
    pubsub {
      enabled = false
    }
  }

  ##### 網路連線 #####
  #### 網路 ####
  network = "projects/${var.network_project}/global/networks/${var.network}"

  # 節點子網路
  subnetwork = "projects/${var.network_project}/regions/${var.region}/subnetworks/${var.subnetwork}"

  #### IPv4網路存取權
  private_cluster_config {
    # 使用外部IP位址存取控制層
    enable_private_endpoint = false

    # 選擇私人叢集
    enable_private_nodes = true

    # 啟用控制層全域存取權
    master_global_access_config {
      enabled = true
    }
    # 控制層IP範圍
    master_ipv4_cidr_block = var.master_ipv4_cidr_block
  }

  # 停用預設snat default is false
  default_snat_status {
    disabled = false
  }

  #### 進階網路選項 ####
  # 啟用虛擬私有雲原生流量轉送功能
  networking_mode = "VPC_NATIVE"

  # 每個節點的pod數量上限
  default_max_pods_per_node = var.max_pod_num

  ip_allocation_policy {
    # 叢集預設Pod位址範圍
    cluster_ipv4_cidr_block = var.cluster_ipv4_cidr

    # 服務位址範圍
    services_ipv4_cidr_block = var.services_ipv4_cidr
  }
  # 啟用kubernetes 網路政策
  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
  }

  # 啟用控制層授權網路
  dynamic "master_authorized_networks_config" {
    for_each = var.enable_master_authorized_networks_config == true ? [1] : []
    content {
      dynamic "cidr_blocks" {
        for_each = var.master_authorized_networks_cidr_blocks
        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = cidr_blocks.value.display_name
        }
      }
    }
  }

  ##### 安全性 #####
  # 啟用二進位授權
  binary_authorization {
    evaluation_mode = "DISABLED"
  }
  # 啟用受保護的GKE節點
  enable_shielded_nodes = true

  # 啟用workload identity
  dynamic "workload_identity_config" {
    for_each = var.work_load[*]
    content {
      workload_pool = var.work_load
    }
  }

  # 舊版安全性選項 -> 核發用戶端憑證
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  ##### 中繼資料 #####
  resource_labels = var.labels

  ##### 功能 ##### 
  #### 作業 ####
  # 啟用cloud logging
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  # 啟用cloud monitoring
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  #### 其他 ####
  addons_config {

    # 網路 -> 啟用 NodeLocal DNSCache
    dns_cache_config {
      enabled = false
    }

    # 啟用 Compute Engine Persistent Disk CSI 驅動程式
    gce_persistent_disk_csi_driver_config {
      enabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    # 網路 -> 啟用 HTTP 負載平衡
    http_load_balancing {
      disabled = false
    }

    # 網路 -> 啟用kubernetes 網路政策
    network_policy_config {
      disabled = true
    }
  }

  database_encryption {
    state = "DECRYPTED"
  }

  datapath_provider = "LEGACY_DATAPATH"
}
