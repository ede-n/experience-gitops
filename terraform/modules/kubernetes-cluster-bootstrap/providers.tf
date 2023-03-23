terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.18.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
  }
  required_version = ">= 1.4.2"
}

provider "kubernetes" {
  config_path    = var.k8s_config_path
  config_context = var.k8s_config_context
}

provider "helm" {
  kubernetes {
    config_path    = var.k8s_config_path
    config_context = var.k8s_config_context
  }
}
