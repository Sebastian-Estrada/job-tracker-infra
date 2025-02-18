variable "db_name" {
  description = "The name of the database to create"
  type        = string
}

variable "username" {
  description = "Master username for the database"
  type        = string
}

variable "password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "engine" {
  description = "Database engine (e.g., postgres, mysql)"
  type        = string
}

variable "engine_version" {
  description = "Database engine version (e.g., 13.7 for Postgres)"
  type        = string
}

variable "instance_class" {
  description = "Instance class for RDS (e.g., db.t3.medium)"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot before deletion"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "tags" {
  description = "Tags to associate with the RDS instance"
  type        = map(string)
  default     = {}
}

variable "parameter_group_name" {
    description = "Name of the DB parameter group to associate"
    type        = string
    default     = ""
}