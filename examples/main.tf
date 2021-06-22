provider "aws" {}

data "aws_iam_policy_document" "policy" {
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
  policy      = data.aws_iam_policy_document.policy.json
  description = "Policy for testing cloud-platform-terraform-irsa"
}

module "irsa" {
  source = "../"

  namespace        = "mogaal-test"
  role_policy_arns = [aws_iam_policy.policy.arn]
}
