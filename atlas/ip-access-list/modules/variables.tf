variable "project_id" {
  description = "The project ID for MongoDB Atlas"
  type        = string
}

variable "cidr_blocks" {
  description = "List of CIDR blocks and their comments"
  type = list(object
    (
      {
        cidr    = string
        comment = string
      }
    )
  )
}
