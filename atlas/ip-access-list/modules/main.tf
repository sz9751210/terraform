resource "mongodbatlas_project_ip_access_list" "access_list" {
  count       = length(var.cidr_blocks)
  project_id  = var.project_id
  cidr_block  = var.cidr_blocks[count.index].cidr
  comment     = var.cidr_blocks[count.index].comment
}

