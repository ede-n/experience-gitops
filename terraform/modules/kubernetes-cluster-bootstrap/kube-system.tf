resource "kubernetes_storage_class" "default" {
  count = var.create_storage_class ? 1 : 0
  metadata {
    name = "default"
  }
  storage_provisioner    = "kubernetes.io/no-provisioner"
  reclaim_policy         = "Delete"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"
}
