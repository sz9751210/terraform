terraform {
  backend "s3" {
    bucket         = "terraform-status"
    key            = "env/eks/terraform.state"
    region         = "ap-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
