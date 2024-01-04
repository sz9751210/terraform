data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "asg_policy" {
  name   = "k8s-cluster-autoscaler-asg-policy"
  policy = file("${path.module}/files/asg_policy.json")
}

resource "aws_iam_role" "cluster_autoscaler" {
  name = "${var.cluster_name}-cluster-autoscaler"
  assume_role_policy = templatefile("${path.module}/files/asg_trust_policy.json.tftpl",
    {
      account_id         = data.aws_caller_identity.current.account_id
      oidc_provider_host = var.oidc_url
    }
  )
}

resource "aws_iam_role_policy_attachment" "asg_policy_attach" {
  role       = aws_iam_role.cluster_autoscaler.name
  policy_arn = aws_iam_policy.asg_policy.arn
}

resource "local_file" "k8s_config" {
  filename = "${path.module}/files/asg.yaml"
  content = templatefile("${path.module}/files/asg.yaml.tftpl", {
    account_id   = data.aws_caller_identity.current.account_id
    cluster_name = var.cluster_name
    }
  )
}

resource "null_resource" "apply_k8s_config" {
  depends_on = [local_file.k8s_config]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.region} && kubectl apply -f ${path.module}/files/asg.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f ${path.module}/files/asg.yaml"
  }
}
