data "aws_caller_identity" "current" {}

data "tls_certificate" "eks_cluster_certificate" {
  url = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.name
}

resource "aws_iam_role" "eks_cluster_iam_role" {
  name               = "${var.name}-AWSServiceRoleForCluster"
  assume_role_policy = file("${path.module}/files/cluster_trust_policy.json")
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_iam_role.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_iam_role.name
}

resource "aws_security_group" "eks_control_plane_sg" {
  name        = "${var.name}-cluster-control-plane-sg"
  description = "Security group for EKS control plane"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-cluster-control-plane-sg"
  }
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.name
  role_arn = aws_iam_role.eks_cluster_iam_role.arn
  version  = var.cluster_version

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    security_group_ids      = [aws_security_group.eks_control_plane_sg.id]
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = var.public_access_cidrs
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy,
    aws_security_group.eks_control_plane_sg
  ]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "kube-proxy"
  addon_version               = var.kube_proxy_version
  resolve_conflicts_on_create = "NONE"
  resolve_conflicts_on_update = "NONE"
  depends_on                  = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "vpc-cni"
  addon_version               = var.vpc_cni_version
  resolve_conflicts_on_create = "NONE"
  resolve_conflicts_on_update = "NONE"
  depends_on                  = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "coredns"
  addon_version               = var.coredns_version
  resolve_conflicts_on_create = "NONE"
  resolve_conflicts_on_update = "NONE"
  depends_on                  = [aws_eks_cluster.eks_cluster]
}

resource "aws_iam_role" "eks_node_group_iam_role" {
  name               = "${var.name}-AWSServiceRoleForNodeGroup"
  assume_role_policy = file("${path.module}/files/node_group_trust_policy.json")
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_iam_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_iam_role.name
}

resource "aws_iam_role_policy_attachment" "eks_ec2_container_registry_read" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_iam_role.name
}

resource "aws_eks_node_group" "eks_node_group" {
  for_each = { for ng in var.node_groups : ng.node_group_name => ng }

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = each.value.node_group_name
  node_role_arn   = aws_iam_role.eks_node_group_iam_role.arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = each.value.node_desired_size
    max_size     = each.value.node_max_size
    min_size     = each.value.node_min_size
  }

  instance_types = each.value.instance_types
  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_ec2_container_registry_read,
  ]
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_cluster_certificate.certificates.0.sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
}

resource "aws_eks_access_entry" "access_entry" {
  for_each = { for user in var.users : user => user }

  cluster_name  = aws_eks_cluster.eks_cluster.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${each.value}"
  type          = "STANDARD"
  depends_on    = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_access_policy_association" "access_policy_association" {
  for_each = { for user in var.users : user => user }

  cluster_name  = aws_eks_cluster.eks_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${each.value}"

  access_scope {
    type = "cluster"
  }
}
