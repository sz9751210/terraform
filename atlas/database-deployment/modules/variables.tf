variable "project_id" {
  type = string
}

variable "db_version" {
  type = string
}

variable "provider_name" {
  type = string
}

variable "instance_size" {
  type = string
}

variable "node_count" {
  type = number
}

variable "compute_max_instance_size" {
  type = string
}

variable "compute_min_instance_size" {
  type = string
}

variable "clusters" {
  type = map(object
    (
      {
        region_name = string
        tags = list(object
          (
            {
              key   = string
              value = string
            }
          )
        )
      }
    )
  )
}
