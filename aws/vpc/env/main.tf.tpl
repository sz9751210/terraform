module "vpc" {
  source               = "../modules"
  prefix               = "${NAME_PREFIX}"
  region               = "${AWS_REGION}"
  main_vpc_cidr        = "${VPC_CIDR_ENV}"
  public_subnets_cidr  = [${PUBLIC_SUBNET_ENV}]
  private_subnets_cidr = [${PRIVATE_SUBNET_ENV}]
  azs                  = [${AZS_ENV}]
}
