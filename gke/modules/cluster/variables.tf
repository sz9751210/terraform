variable "project" {
  type = string
}

variable "network_project" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "master_ipv4_cidr_block" {
  type = string
}

variable "cluster_ipv4_cidr" {
  type = string
}

variable "services_ipv4_cidr" {
  type = string
}

variable "node_version" {
  type = string
}

variable "max_pod_num" {
  type = number
}

variable "zone" {
  type = string
}

variable "region" {
  type = string
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "disk_size_gb" {
  type = number
}

variable "disk_type" {
  type = string
}

variable "labels" {
  type = map(string)
}

variable "enable_master_authorized_networks_config" {
  type = bool
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
}

variable "work_load" {
  type = string
}
