variable "max_node_count" {
  type = number
}

variable "min_node_count" {
  type = number
}

variable "cluster_name" {
  type = string
}

variable "initial_node_count" {
  type = number
}

variable "cluster_zone" {
  type = string
}

variable "node_zone" {
  type = string
}

variable "max_pod_num" {
  type = number
}

variable "nodepool_name" {
  type = string
}

variable "labels" {
  type = map(string)
}

variable "disk_size_gb" {
  type = number
}

variable "disk_type" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "node_count" {
  type = number
}

variable "project" {
  type = string
}

variable "max_surge" {
  type = number
}

variable "max_unavailable" {
  type = number
}

variable "node_version" {
  type = string
}
