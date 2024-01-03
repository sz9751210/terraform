terraform {
  backend "s3" {
    bucket         = "terraform-base-bucket"
    key            = "dev-terraform-status/terraform.tfstate"
    region         = "ap-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
