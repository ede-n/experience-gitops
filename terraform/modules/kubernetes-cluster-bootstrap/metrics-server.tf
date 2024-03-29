resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = "3.8.4"
  namespace  = local.monitoring_namespace

  values = [
    file("${path.module}/helm-values/metrics-server.yaml")
  ]
}
