output "aws_iam_role_name" {
  description = "IAM role name to assume by the SA using annotations"
  value       = module.irsa.aws_iam_role_name
}
