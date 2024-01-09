data "aws_caller_identity" "current" {}

resource "aws_iam_role" "alb_iam_role" {
  name = "${var.cluster_name}-AWSServiceRoleForEKSLoadBalancerController"
  assume_role_policy = templatefile("${path.module}/files/alb_trust_policy.json.tftpl",
    {
      account_id         = data.aws_caller_identity.current.account_id
      oidc_provider_host = var.oidc_url
    }
  )
}

resource "aws_iam_role_policy_attachment" "alb_attach" {
  role       = aws_iam_role.alb_iam_role.name
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/AWSLoadBalancerControllerIAMPolicy"
}

resource "kubernetes_service_account" "aws_load_balancer_controller_service_account" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.cluster_name}-AWSServiceRoleForEKSLoadBalancerController",
    }
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  depends_on = [aws_iam_role.alb_iam_role, kubernetes_service_account.aws_load_balancer_controller_service_account]
}
