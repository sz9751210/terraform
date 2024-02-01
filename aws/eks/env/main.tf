data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = "aws-eks-terraform-status"
    key            = "env/vpc/terraform.state"
    region         = "ap-east-1"
    dynamodb_table = "aws-eks-terraform-locks"
    encrypt        = true
  }
}

module "eks" {
  source              = "../modules"
  name                = "aws-eks"
  region              = "ap-east-1"
  cluster_version     = "1.29"
  kube_proxy_version  = "v1.29.0-eksbuild.1"
  vpc_cni_version     = "v1.16.0-eksbuild.1"
  coredns_version     = "v1.11.1-eksbuild.4"
  vpc_id              = data.terraform_remote_state.vpc.outputs.aws_vpc_id
  private_subnet_ids  = data.terraform_remote_state.vpc.outputs.aws_private_subnet_ids
  public_access_cidrs = ["111.234.33.55/32", "113.234.55.44/32"]
  users = ["alan_wang"]
  node_groups = [
        {
      node_group_name   = "node-group-1"
      instance_types    = ["t3.medium"]
      node_desired_size = 1
      node_max_size     = 3
      node_min_size     = 1
    },    {
      node_group_name   = "node-group-2"
      instance_types    = ["t3.large"]
      node_desired_size = 1
      node_max_size     = 3
      node_min_size     = 1
    },
  ]
}
