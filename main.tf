locals {
  # Generic configuration
  identifier = "cloud-platform-irsa-${random_id.id.hex}"

  # Tags
  default_tags = {
    # Mandatory
    business-unit = var.business_unit
    application   = var.application
    is-production = var.is_production
    owner         = var.team_name
    namespace     = var.namespace # for billing and identification purposes

    # Optional
    environment-name       = var.environment_name
    infrastructure-support = var.infrastructure_support
  }
}

###################
# Get EKS cluster #
###################
data "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster_name
}

########################
# Generate identifiers #
########################
resource "random_id" "id" {
  byte_length = 8
}

#########################
# Create assumable role #
#########################
module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.20.0"

  allow_self_assume_role        = false
  create_role                   = true
  max_session_duration          = 3600
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account_name}"]
  provider_url                  = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  role_name                     = "${local.identifier}-${data.aws_eks_cluster.eks_cluster.name}"
  role_policy_arns              = var.role_policy_arns

  tags = local.default_tags
}

##########################
# Create service account #
##########################
resource "kubernetes_service_account" "generated_sa" {
  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_assumable_role.iam_role_arn
    }
  }
  automount_service_account_token = true
}
