data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = "${NAME_PREFIX}-terraform-status"
    key            = "env/vpc/terraform.state"
    region         = "${AWS_REGION}"
    dynamodb_table = "${NAME_PREFIX}-terraform-locks"
    encrypt        = true
  }
}

module "eks" {
  source              = "../modules"
  name                = "${NAME_PREFIX}"
  target_region       = "${AWS_REGION}"
  cluster_version     = "${CLUSTER_VERSION}"
  kube_proxy_version  = "${KUBE_PROXY_VERSION}"
  vpc_cni_version     = "${VPC_CNI_VERSION}"
  coredns_version     = "${COREDNS_VERSION}"
  vpc_id              = data.terraform_remote_state.vpc.outputs.aws_vpc_id
  private_subnet_ids  = data.terraform_remote_state.vpc.outputs.aws_private_subnet_ids
  public_access_cidrs = [${PUBLIC_ACCESS_CIDRS}]
  users = [${USERS}]
  node_groups = [
    ${NODE_GROUPS}
  ]
}
