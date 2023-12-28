module "cluster_test" {
  source                 = "../../modules/cluster"
  project_id             = "project-id"     # 叢集基本資料
  network_project_id     = "project-id"     # 網路連線 -> 網路
  cluster_name           = "gke"            # 叢集基本資料
  master_ipv4_cidr_block = "172.16.0.0/28"  # 網路連線 -> IPv4網路存取權
  cluster_ipv4_cidr      = "192.168.0.0/18" # 網路連線 -> 進階網路選項 -> 叢集預設Pod位址範圍
  services_ipv4_cidr     = "10.26.10.0/23"  # 網路連線 -> 進階網路選項 -> 服務位址範圍
  node_version           = "1.27.3-gke.100" # 叢集基本資料 -> 控制層版本
  max_pod_num            = 110              # 網路連線 -> 進階網路選項 -> 每個節點的pod數量上限
  zone                   = "asia-east1-b"   # 叢集基本資料
  region                 = "asia-east1"     # 網路連線 -> 網路
  network                = "default"        # 網路連線 -> 網路
  subnetwork             = "default"        # 網路連線 -> 網路 -> 節點子網路
  machine_type           = "n1-standard-2"  # 節點集區 -> 節點數 -> 節點類型
  disk_size_gb           = 100              # 節點集區 -> 節點數 -> 磁碟大小
  disk_type              = "pd-standard"    # 節點集區 -> 節點數 -> 磁碟類型
  labels = {                                # 節點集區 -> 節點數, 安全性 -> 中繼資料
    env = "dev"
  }
  enable_master_authorized_networks_config = false # 網路連線 -> 進階網路選項 -> 啟用控制層授權網路
  master_authorized_networks_cidr_blocks = [       # 網路連線 -> 進階網路選項 -> 啟用控制層授權網路
    {
      cidr_block   = "0.0.0.0/0"
      display_name = "Google Cloud Build"
    }
  ]
  work_load = null # 安全性
}
