output "aws_iam_role_name" {
  description = "IAM role name to assume by the SA using annotations"
  value       = module.iam_assumable_role.iam_role_name
}

output "service_account_name" {
  description = "Name of the service account created"
  value       = kubernetes_service_account.generated_sa.metadata[0]
}
