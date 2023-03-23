variable "create_storage_class" {
  description = "Create a storage class for the cluster"
  type        = bool
  default     = true
}

# ArgoCD
variable "helm_config" {
  description = "ArgoCD Helm Chart Config values"
  type        = any
  default     = {}
}

variable "k8s_config_context" {
  description = "Kubernetes config context"
  type = string
}

variable "k8s_config_path" {
  description = "Kubernetes config path" 
  type = string
}