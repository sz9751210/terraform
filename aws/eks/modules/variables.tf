variable "name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "public_access_cidrs" {
  type = list(string)
}

variable "kube_proxy_version" {
  type = string
}

variable "vpc_cni_version" {
  type = string
}

variable "coredns_version" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "node_desired_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "node_min_size" {
  type = number
}

variable "region" {
  type = string
}
