module "vpc" {
  source               = "../modules"
  prefix               = "aws"
  region               = "ap-east-1"
  main_vpc_cidr        = "10.0.0.0/16"
  public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets_cidr = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  azs                  = ["ap-east-1a", "ap-east-1b", "ap-east-1c"]
}
