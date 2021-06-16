data "aws_eks_cluster" "live" {
  name = "live"
}

resource "random_id" "id" {
  byte_length = 8
}

locals {
  identifier = "cloud-platform-${random_id.id.hex}"
}

module "iam_assumable_role" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.1.0"
  create_role                   = true
  role_name                     = local.identifier
  provider_url                  = data.aws_eks_cluster.live.identity[0].oidc[0].issuer
  role_policy_arns              = var.role_policy_arns
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
}
