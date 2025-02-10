# modules/kubernetes/outputs.tf
output "backend_service_name" {
  description = "The name of the backend Kubernetes service."
  value       = kubernetes_service.backend.metadata[0].name
}

output "frontend_service_name" {
  description = "The name of the frontend Kubernetes service."
  value       = kubernetes_service.frontend.metadata[0].name
}

# output "backend_service_endpoint" {
#   description = "The endpoint for the backend Kubernetes service."
#   value       = kubernetes_service.backend.status[0].load_balancer[0].ingress[0].hostname
# }

output "frontend_service_endpoint" {
  description = "The endpoint for the frontend Kubernetes service."
  value       = kubernetes_service.frontend.status[0].load_balancer[0].ingress[0].hostname
}