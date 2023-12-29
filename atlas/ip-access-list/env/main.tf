module "ip_access_list" {
  source      = "../modules"
  project_id  = "your-project-id"

  cidr_blocks = [
    {
      cidr    = "127.0.0.1/32"
      comment = "localhost"
    }
  ]
}
