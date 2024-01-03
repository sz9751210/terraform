apiVersion: v1
kind: ServiceAccount
metadata:
  name: efs-csi-node-sa
  namespace: kube-system
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::${account_id}:role/${iam_role_name}
