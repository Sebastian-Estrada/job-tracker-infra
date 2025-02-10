# modules/kubernetes/variables.tf
variable "cluster_endpoint" {
  description = "The endpoint for the EKS cluster's Kubernetes API server."
  type        = string
}

variable "cluster_ca_cert" {
  description = "The base64-encoded certificate authority data for the EKS cluster."
  type        = string
}

variable "cluster_token" {
  description = "The token for authenticating with the EKS cluster."
  type        = string
  sensitive   = true
}

variable "backend_image" {
  description = "The Docker image for the backend application."
  type        = string
}

variable "frontend_image" {
  description = "The Docker image for the frontend application."
  type        = string
}

variable "backend_replicas" {
  description = "The number of replicas for the backend deployment."
  type        = number
  default     = 2
}

variable "frontend_replicas" {
  description = "The number of replicas for the frontend deployment."
  type        = number
  default     = 2
}