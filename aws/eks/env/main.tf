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

module "eks" {
  source             = "../modules"
  region             = "ap-east-1"
  name               = "eks"
  cluster_version    = "1.28"
  kube_proxy_version = "v1.28.1-eksbuild.1"
  vpc_cni_version    = "v1.14.1-eksbuild.1"
  coredns_version    = "v1.10.1-eksbuild.2"
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.aws_private_subnet_ids
  vpc_id             = data.terraform_remote_state.vpc.outputs.aws_vpc_id
  public_access_cidrs = [
    "0.0.0.0/0"
  ]
  instance_types    = ["t3.medium"]
  node_desired_size = 2
  node_min_size     = 1
  node_max_size     = 20
}
