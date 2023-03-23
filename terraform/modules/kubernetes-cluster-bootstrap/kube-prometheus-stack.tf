

resource "kubernetes_namespace" "kube-prom-stack" {
  metadata {
    name = local.kube_prom_stack_helm_config["namespace"]
  }
}

resource "helm_release" "kube-prom-stack" {
  name       = local.kube_prom_stack_helm_config["name"]
  namespace  = kubernetes_namespace.kube-prom-stack.metadata[0].name
  chart      = local.kube_prom_stack_helm_config["chart"]
  version    = local.kube_prom_stack_helm_config["version"]
  repository = local.kube_prom_stack_helm_config["repository"]
  wait       = local.kube_prom_stack_helm_config["wait"]
  values     = local.kube_prom_stack_helm_config["values"]

}


