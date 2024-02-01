terraform {
  backend "s3" {
    bucket         = "aws-eks-terraform-status"
    key            = "env/vpc/terraform.state"
    region         = "ap-east-1"
    dynamodb_table = "aws-eks-terraform-locks"
    encrypt        = true
  }
}
