output "vpc_info" {
  value = resource.aws_vpc.main_vpc
}

output "public_subnet_info" {
  value = resource.aws_subnet.public_subnets[*]
}

output "private_subnet_info" {
  value = resource.aws_subnet.private_subnets[*]
}
