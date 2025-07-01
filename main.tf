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

###########################
# Get account information #
###########################
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

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
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.58.0"

  allow_self_assume_role     = false
  assume_role_condition_test = "StringEquals"
  create_role                = true
  force_detach_policies      = true
  role_name                  = "${local.identifier}-${data.aws_eks_cluster.eks_cluster.name}"
  role_policy_arns           = var.role_policy_arns

  oidc_providers = {
    (data.aws_eks_cluster.eks_cluster.name) : {
      provider_arn               = "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}"
      namespace_service_accounts = ["${var.namespace}:${var.service_account_name}"]
    }
  }

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
