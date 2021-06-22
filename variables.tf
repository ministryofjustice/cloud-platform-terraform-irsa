variable "service_account" {
  description = "The service account name to be linked with the AWS role"
  type        = string
}

variable "eks_cluster" {
  description = "EKS cluster name (workspace) where the role is going to be linked"
  type        = string
  default     = "live"
}

variable "namespace" {
  description = "namespace where the service account to be linked is located"
  type        = string
}

variable "role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
}
