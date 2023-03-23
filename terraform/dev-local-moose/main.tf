resource "null_resource" "kind-cluster" {
  count = var.create_cluster ? 1 : 0
  provisioner "local-exec" {
    command = "kind create cluster --name ${var.short_name} --config ${path.module}/kind-cluster-config.yaml"
  }
}

module "kubernetes-cluster-bootstrap" {
  source = "../modules/kubernetes-cluster-bootstrap"

  k8s_config_context = var.k8s_config_context
  k8s_config_path    = var.k8s_config_path
}
