
variable "namespace" {
  description = "namespace where the service account to be linked is located"
  type        = string
}

variable "role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
}

variable "service_account" {
  description = "service accounts"
  type        = string
  default     = ""
}

variable "eks_cluster_name" {
  description = "The name of the eks cluster to retrieve the OIDC information"
  type        = string
}
