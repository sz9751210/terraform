terraform {
  backend "s3" {
    bucket         = "terraform-base-bucket"
    key            = "dev-bucket-state/terraform.tfstate"
    region         = "ap-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
