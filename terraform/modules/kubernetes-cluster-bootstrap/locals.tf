locals {
  monitoring_namespace = "monitoring"
  kube_prom_stack_name      = "kube-prometheus-stack"
  default_kube_prom_stack_helm_config = {
    name       = local.kube_prom_stack_name
    namespace  = local.monitoring_namespace
    chart      = local.kube_prom_stack_name
    version    = "45.7.1"
    repository = "https://prometheus-community.github.io/helm-charts"
    wait       = false
    values = [
      file("${path.module}/helm-values/kube-prometheus-stack.yaml")
    ]
  }
  kube_prom_stack_helm_config = merge(local.default_kube_prom_stack_helm_config, var.helm_config)
}