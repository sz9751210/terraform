module "dev-bucket" {
  source              = "../modules"
  bucket_name         = "dev-terraform-status"
  dynamodb_table_name = "dev-terraform-locks"
  region              = "ap-east-1"
}
