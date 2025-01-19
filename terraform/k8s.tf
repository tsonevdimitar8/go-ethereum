provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Namespace Resource
resource "kubernetes_manifest" "devnet_namespace" {
  manifest = yamldecode(file("${path.module}/../kubernetes-resources/namespace.yaml"))
}

# Deployment Resource
resource "kubernetes_manifest" "devnet_deployment" {
  manifest = yamldecode(file("${path.module}/../kubernetes-resources/deployment.yaml"))
  depends_on = [kubernetes_manifest.devnet_namespace]
}

# Service Resource
resource "kubernetes_manifest" "devnet_service" {
  manifest = yamldecode(file("${path.module}/../kubernetes-resources/service.yaml"))
  depends_on = [kubernetes_manifest.devnet_namespace]
}
