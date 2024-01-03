data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket         = "terraform-status"
    key            = "env/eks/terraform.state"
    region         = "ap-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "alb" {
  source       = "../modules"
  region       = "ap-east-1"
  cluster_name = data.terraform_remote_state.eks.outputs.cluster_name
  oidc_url     = data.terraform_remote_state.eks.outputs.openid_connect_provider_url
}
