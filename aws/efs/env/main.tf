data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = "terraform-status"
    key            = "env/vpc/terraform.state"
    region         = "ap-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

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

module "efs" {
  source                 = "../modules"
  region                 = "ap-east-1"
  cluster_name           = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_endpoint       = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  public_subnet_ids      = data.terraform_remote_state.vpc.outputs.aws_public_subnet_ids
  vpc_id                 = data.terraform_remote_state.vpc.outputs.aws_vpc_id
  oidc_url               = data.terraform_remote_state.eks.outputs.openid_connect_provider_url
}
