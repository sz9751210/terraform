variable "region" {
  type = string
}

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

variable "users" {
  type        = list(string)
}

variable "node_groups" {
  type = list(object
    (
      {
        node_group_name   = string
        instance_types    = list(string)
        node_desired_size = number
        node_max_size     = number
        node_min_size     = number
      }
    )
  )
}
