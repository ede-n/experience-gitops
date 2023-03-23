variable "short_name" {
  description = "Short name for the stack"
  type        = string
  default     = "moose"
}

variable "create_cluster" {
  description = "value to create a cluster"
  type        = bool
  default     = true

}

variable "k8s_config_context" {
  description = "Kubernetes context to use"
  type        = string
  default     = "kind-moose"
}

variable "k8s_config_path" {
  description = "Kubernetes config context"
  type        = string
  default     = "~/.kube/config"
}
