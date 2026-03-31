resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = [
      var.public_subnet_a_id,
      var.public_subnet_b_id
    ]
  }

  depends_on = [
    var.eks_policy
  ]
}

