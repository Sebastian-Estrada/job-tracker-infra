# This Terraform configuration sets up Prometheus and Grafana on a Kubernetes cluster using Helm.
#
# The `terraform` block specifies the required providers:
# - `helm` provider from HashiCorp, version 2.17.0
# - `kubernetes` provider from HashiCorp, version 2.7
#
# The `provider "kubernetes"` block configures the Kubernetes provider with the cluster endpoint, token, and CA certificate.
#
# The `provider "helm"` block configures the Helm provider to use the Kubernetes provider's configuration.
#
# The `helm_release "prometheus"` resource installs Prometheus in the "monitoring" namespace, creating the namespace if it doesn't exist.
# - The Prometheus Helm chart is sourced from the Prometheus Community repository, version 27.3.1.
# - The `values` block disables persistent volume and alertmanager for the Prometheus server.
#
# The `helm_release "grafana"` resource installs Grafana in the "monitoring" namespace, creating the namespace if it doesn't exist.
# - The Grafana Helm chart is sourced from the Grafana repository, version 7.0.0.
# - The `values` block sets the admin password to "admin".

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7"
    }
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  token                  = var.cluster_token
  cluster_ca_certificate = base64decode(var.cluster_ca_cert)
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_ca_cert)
  }
}

resource "helm_release" "prometheus" {
  name             = "prometheus"
  namespace        = "monitoring"
  create_namespace = true
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  version          = "27.3.1"

  values = [
    <<-EOT
    alertmanager:
      enabled: false
    alertmanagerFiles: {}
    server:
      persistentVolume:
        enabled: false
    EOT
  ]
}

resource "helm_release" "grafana" {
  name             = "grafana"
  namespace        = "monitoring"
  create_namespace = true
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  version          = "7.0.0"

  values = [
    <<-EOT

    adminPassword: "admin"
    EOT
  ]
}
