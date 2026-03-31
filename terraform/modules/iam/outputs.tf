output "eks_role" {
  value = aws_iam_role.eks_role
}

output "node_role_arn" {
  value = aws_iam_role.node_role.arn
}

output "policies" {
  value = [
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy,
    aws_iam_role_policy_attachment.node_policy,
  ]
}

output "eks_policy" {
  value = aws_iam_role_policy_attachment.eks_policy
}

