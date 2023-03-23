locals {
  argocd_namespace = "argocd"
  argocd_name      = "argo-cd"
  default_argocd_helm_config = {
    name       = local.argocd_name
    namespace  = local.argocd_namespace
    chart      = local.argocd_name
    version    = "5.27.1"
    repository = "https://argoproj.github.io/argo-helm"
    wait       = false
    values = [
      file("${path.module}/helm-values/argocd.yaml")
    ]
  }

  argocd_helm_config = merge(local.default_argocd_helm_config, var.helm_config)
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = local.argocd_helm_config["namespace"]
  }
}

resource "helm_release" "argocd" {
  name       = local.argocd_helm_config["name"]
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  chart      = local.argocd_helm_config["chart"]
  version    = local.argocd_helm_config["version"]
  repository = local.argocd_helm_config["repository"]
  wait       = local.argocd_helm_config["wait"]
  values     = local.argocd_helm_config["values"]
}
