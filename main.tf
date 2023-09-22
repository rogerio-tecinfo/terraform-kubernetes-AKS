terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.73.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

provider "kubernetes" {
  host = module.lab.k8s_host

  client_certificate     = base64decode(module.lab.k8s_client_certificate)
  client_key             = base64decode(module.lab.k8s_client_certificate_key)
  cluster_ca_certificate = base64decode(module.lab.k8s_cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host     = module.lab.k8s_host

    client_certificate     = base64decode(module.lab.k8s_client_certificate)
    client_key             = base64decode(module.lab.k8s_client_certificate_key)
    cluster_ca_certificate = base64decode(module.lab.k8s_cluster_ca_certificate)
  }
}


module "lab" {
  source = "https://github.com/rogerio-tecinfo/terraform-module-aks.git"
  env                     = "lab"
  project_name            = "zeus"
  node_pool_name          = "default"
  client_id               = "ced20ee0-d22e-4d14-baa0-88f70c889ce4"
  client_secret           = "V~k8Q~R4IaUzxW3xAcik5xXcAODVRP4-7BYKtcDk"
  k8s_node_vm_size        = "Basic_A2"
  k8s_node_count          = 1
  k8s_node_os_disk_size   = 30
  enable_prometheus       = true
  enable_grafana   = true 
}