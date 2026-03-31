
resource "aws_eks_node_group" "workers" {
  cluster_name    = var.cluster_name
  node_group_name = "workers"
  node_role_arn   = var.node_role_arn
  instance_types = [
    var.instance_type
  ]

  subnet_ids = [
    var.public_subnet_a_id,
    var.public_subnet_b_id
  ]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    var.policies
  ]
}
