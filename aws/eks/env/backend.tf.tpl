terraform {
  backend "s3" {
    bucket         = "${NAME_PREFIX}-terraform-status"
    key            = "env/eks/terraform.state"
    region         = "${AWS_REGION}"
    dynamodb_table = "${NAME_PREFIX}-terraform-locks"
    encrypt        = true
  }
}
