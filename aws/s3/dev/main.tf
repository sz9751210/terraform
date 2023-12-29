module "base-bucket" {
  source              = "../modules"
  dynamodb_table_name = "dev-terraform-locks"
  bucket_name         = "dev-terraform-bucket"
  region              = "ap-east-1"
}
