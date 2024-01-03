data "aws_caller_identity" "current" {}

data "template_file" "trust_policy" {
  template = file("${path.module}/files/efs_trust_policy.json.tpl")

  vars = {
    account_id         = data.aws_caller_identity.current.account_id
    oidc_provider_host = var.oidc_url
  }
}

resource "aws_efs_file_system" "aws_efs" {
  creation_token   = var.cluster_name
  encrypted        = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  tags = {
    Name = var.cluster_name
  }
}

resource "aws_security_group" "efs_sg" {
  name        = "${var.cluster_name}-efs-sg"
  description = "Security group for EKS EFS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-efs-sg"
  }
}

resource "aws_efs_mount_target" "efs_mount_target" {
  for_each        = toset(var.public_subnet_ids)
  file_system_id  = aws_efs_file_system.aws_efs.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_iam_role" "efs_role" {
  name               = "${var.name}-AmazonEKS_EFS_CSI_DriverRole"
  assume_role_policy = data.template_file.trust_policy.rendered
}

resource "aws_iam_role_policy_attachment" "example_attach" {
  role       = aws_iam_role.efs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}

resource "kubernetes_service_account" "efs_csi_controller_sa" {
  metadata {
    name      = "efs-csi-controller-sa"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.cluster_name}-AmazonEKS_EFS_CSI_DriverRole"
    }
  }
}

resource "kubernetes_service_account" "efs_csi_node_sa" {
  metadata {
    name      = "efs-csi-node-sa"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.cluster_name}-AmazonEKS_EFS_CSI_DriverRole"
    }
  }
}

# Helm chart for AWS EFS CSI Driver (requires Helm provider)
resource "helm_release" "aws_efs_csi_driver" {
  name       = "aws-efs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart      = "aws-efs-csi-driver"
  namespace  = "kube-system"

  set {
    name  = "controller.serviceAccount.create"
    value = "false"
  }
  set {
    name  = "controller.serviceAccount.name"
    value = "efs-csi-controller-sa"
  }
  set {
    name  = "node.serviceAccount.create"
    value = "false"
  }
  set {
    name  = "node.serviceAccount.name"
    value = "efs-csi-node-sa"
  }

  depends_on = [kubernetes_service_account.efs_csi_controller_sa, kubernetes_service_account.efs_csi_node_sa]
}

resource "kubernetes_storage_class" "efs_sc" {
  metadata {
    name = "efs-sc"
  }

  storage_provisioner = "efs.csi.aws.com"

  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId     = aws_efs_file_system.aws_efs.id
    directoryPerms   = "700"
  }

  depends_on = [helm_release.aws_efs_csi_driver]
}
