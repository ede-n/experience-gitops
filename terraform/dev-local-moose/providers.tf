terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.18.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }

  required_version = "1.4.2"
  backend "local" {
    path = "../../../tf-local-state-dir/dev-local-moose/terraform.tfstate"
  }
}


