# live/production/variables.tf
variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS managed node group."
  type        = string
}

variable "instance_types" {
  description = "The instance types to use for the worker nodes."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "The desired number of worker nodes in the node group."
  type        = number
  default     = 2
}

variable "min_size" {
  description = "The minimum number of worker nodes in the node group."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of worker nodes in the node group."
  type        = number
  default     = 3
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default     = {}
}


variable "backend_image" {
  description = "The Docker image for the backend application."
  type        = string
  default = "backend"
}

variable "frontend_image" {
  description = "The Docker image for the frontend application."
  type        = string
  default = "frontend"
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