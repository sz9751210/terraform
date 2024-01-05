resource "aws_iam_policy" "alb_policy" {
  name   = "AWSLoadBalancerControllerIAMPolicy"
  policy = file("${path.module}/files/alb_policy.json")
}

resource "aws_iam_policy" "asg_policy" {
  name   = "k8s-cluster-autoscaler-asg-policy"
  policy = file("${path.module}/files/asg_policy.json")
}
