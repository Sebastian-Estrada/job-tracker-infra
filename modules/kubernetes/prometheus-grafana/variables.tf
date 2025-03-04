variable "cluster_endpoint" {
  type        = string
  description = "El endpoint del clúster EKS"
}

variable "cluster_ca_cert" {
  type        = string
  description = "El certificado de la autoridad del clúster"
}

variable "cluster_token" {
  type        = string
  description = "Token de autenticación para el clúster EKS"
}


variable "prometheus_volume_id" {
  description = "ID del volumen EBS para Prometheus"
  type        = string
}

variable "grafana_volume_id" {
  description = "ID del volumen EBS para Grafana"
  type        = string
}