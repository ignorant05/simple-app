provider "helm" {
  kubernetes = {
    host = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(
      aws_eks_cluster.main.certificate_authority[0].data
    )
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true

  set = [{
    name  = "controller.service.type"
    value = "LoadBalancer"
  }]
}
