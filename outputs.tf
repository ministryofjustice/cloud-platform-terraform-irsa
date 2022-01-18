output "aws_iam_role_name" {
  description = "IAM role name to assume by the SA using annotations"
  value       = module.iam_assumable_role.iam_role_name
}

output "service_account_name" {
  # NB: This is not the name of the service account, but the entire object
  description = "Service account created"
  value       = kubernetes_service_account.generated_sa.metadata[0]
}
