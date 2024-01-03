data "aws_caller_identity" "current" {}

data "template_file" "asg_trust_policy" {
  template = file("${path.module}/files/asg_trust_policy.json.tpl")

  vars = {
    account_id         = data.aws_caller_identity.current.account_id
    oidc_provider_host = var.oidc_url
  }
}

data "template_file" "asg_config" {
  template = file("${path.module}/files/asg.yaml.tpl")

  vars = {
    account_id   = data.aws_caller_identity.current.account_id
    cluster_name = var.cluster_name
  }
}

resource "aws_iam_policy" "asg_policy" {
  name   = "k8s-cluster-autoscaler-asg-policy"
  policy = file("${path.module}/files/asg_policy.json")
}

resource "aws_iam_role" "cluster_autoscaler" {
  name               = "${var.cluster_name}-cluster-autoscaler"
  assume_role_policy = data.template_file.asg_trust_policy.rendered
}

resource "aws_iam_role_policy_attachment" "asg_policy_attach" {
  policy_arn = aws_iam_policy.asg_policy.arn
  role       = aws_iam_role.cluster_autoscaler.name
}

resource "local_file" "k8s_config" {
  filename = "${path.module}/files/asg.yaml"
  content  = data.template_file.asg_config.rendered
}

resource "null_resource" "apply_k8s_config" {
  depends_on = [local_file.k8s_config]

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/files/asg.yaml"
  }
}
