# live/production/outputs.tf
output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster's Kubernetes API server."
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_node_group_arn" {
  description = "The ARN of the EKS managed node group."
  value       = module.eks.node_group_arn
}

# live/production/outputs.tf
# output "backend_service_endpoint" {
#   description = "The endpoint for the backend Kubernetes service."
#   value       = module.kubernetes.backend_service_endpoint
# }

output "frontend_service_endpoint" {
  description = "The endpoint for the frontend Kubernetes service."
  value       = module.kubernetes.frontend_service_endpoint
}

output "cluster_token" {
  value = data.aws_eks_cluster_auth.cluster.token
  sensitive = true
}