data "aws_iam_policy_document" "document" {
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "simple-policy-for-testing-irsa"
  path        = "/cloud-platform/"
  policy      = data.aws_iam_policy_document.document.json
  description = "Policy for testing cloud-platform-terraform-irsa"
}

module "irsa" {
  #always replace with latest version from Github
  #   source = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.0.6"
  source = "../"

  eks_cluster_name =  var.eks_cluster_name
  namespace        = "irsa-test"
  role_policy_arns = [aws_iam_policy.policy.arn]
}

resource "kubernetes_secret" "irsa" {
  metadata {
    name      = "irsa"
    namespace = "irsa-test"
  }
  data = {
    role           = module.irsa.aws_iam_role_name
    serviceaccount = module.irsa.service_account_name.name
  }
}
