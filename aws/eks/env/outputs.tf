output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with the EKS cluster."
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_id" {
  description = "The ID of the EKS cluster."
  value       = module.eks.cluster_id
}

output "cluster_security_group_id" {
  description = "The security group ID associated with the EKS cluster."
  value       = module.eks.cluster_security_group_id
}

output "cluster_token" {
    description = "The token to use to authenticate with the EKS cluster."
    value       = module.eks.cluster_token
    sensitive = true
}

output "openid_connect_provider_arn" {
  description = "The ARN assigned by AWS to the OpenID Connect Provider."
  value       = module.eks.openid_connect_provider_arn
}

output "openid_connect_provider_url" {
  description = "The URL of the OpenID Connect Provider."
  value       = module.eks.openid_connect_provider_url
}
