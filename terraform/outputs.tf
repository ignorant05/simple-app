output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.host
}

output "kubeconfig_cmd" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name}"
}
