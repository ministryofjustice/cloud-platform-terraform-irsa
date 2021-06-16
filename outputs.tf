output "aws_iam_role_name" {
  description = "IAM role name to assume by the SA using annotations"
  value       = module.iam_assumable_role.iam_role_name
}
