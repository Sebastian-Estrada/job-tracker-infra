# modules/eks/outputs.tf
output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster's Kubernetes API server."
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "The base64-encoded certificate authority data for the EKS cluster."
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "node_group_arn" {
  description = "The ARN of the EKS managed node group."
  value       = module.eks.eks_managed_node_groups[var.node_group_name].node_group_arn
}