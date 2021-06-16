variable "service_account" {
  description = "The service account name to be linked with the AWS role"
  type        = string
}

variable "namespace" {
  description = "namespace where the service account to be linked is located"
  type        = string
}

variable "role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
}

