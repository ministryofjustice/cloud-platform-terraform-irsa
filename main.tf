data "aws_eks_cluster" "live" {
  name = var.eks_cluster
}

resource "random_id" "id" {
  byte_length = 8
}

locals {
  service_account = var.service_account != "" ? var.service_account : "cloud-platform-${random_id.id.hex}"
}

module "iam_assumable_role" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.1.0"
  create_role                   = true
  role_name                     = "${local.service_account}-${var.eks_cluster}"
  provider_url                  = data.aws_eks_cluster.live.identity[0].oidc[0].issuer
  role_policy_arns              = var.role_policy_arns
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${local.service_account}"]
}

resource "kubernetes_service_account" "generated_sa" {
  metadata {
    name      = local.service_account
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_assumable_role.iam_role_arn
    }
  }
  automount_service_account_token = true
}
