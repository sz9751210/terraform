module "base-bucket" {
  source              = "../modules"
  dynamodb_table_name = "terraform-locks"
  bucket_name         = "terraform-base-bucket"
  region              = "ap-east-1"
}
