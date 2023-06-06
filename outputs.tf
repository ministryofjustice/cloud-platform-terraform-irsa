output "role_name" {
  description = "IAM role name to assume by the SA using annotations"
  value       = module.iam_assumable_role.iam_role_name
}

output "role_arn" {
  description = "ARN of IAM role assumed by the service account"
  value       = module.iam_assumable_role.iam_role_arn
}

output "service_account" {
  # NB: This is not the name of the service account, but the entire object
  description = "Service account metadata"
  value       = kubernetes_service_account.generated_sa.metadata[0]
}
