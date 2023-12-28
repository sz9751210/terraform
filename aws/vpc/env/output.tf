output "aws_public_subnet_ids" {
  value = module.vpc.public_subnet_info[*].id
}

output "aws_private_subnet_ids" {
  value = module.vpc.private_subnet_info[*].id
}

output "aws_vpc_id" {
  value = module.vpc.vpc_info.id
}
