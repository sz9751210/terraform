output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

output "cluster_security_group_id" {
  value = aws_security_group.eks_control_plane_sg.id
}

output "cluster_token" {
  value = data.aws_eks_cluster_auth.cluster_auth.token
}

output "node_group_arn" {
  value = { for key, ng in aws_eks_node_group.eks_node_group : key => ng.arn }
}

output "node_group_status" {
  value = { for key, ng in aws_eks_node_group.eks_node_group : key => ng.status }
}

output "openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}

output "openid_connect_provider_url" {
  value = aws_iam_openid_connect_provider.oidc_provider.url
}
