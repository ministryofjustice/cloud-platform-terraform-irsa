# cloud-platform-terraform-irsa

This module is created for teams in order to connect AWS roles to our live clusters using IRSA (IAM Roles for Service Accounts). 

## Usage

See [examples](examples/) folder

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| kubernetes | n/a |
| random | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| iam_assumable_role | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.1.0 |

## Resources

| Name |
|------|
| [aws_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) |
| [kubernetes_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) |
| [random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| eks\_cluster | EKS cluster name (workspace) where the role is going to be linked | `string` | `"live"` | no |
| namespace | namespace where the service account to be linked is located | `string` | n/a | yes |
| role\_policy\_arns | List of ARNs of IAM policies to attach to IAM role | `list(string)` | n/a | yes |
| service\_account | service accounts | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_iam\_role\_name | IAM role name to assume by the SA using annotations |
| aws\_iam\_role\_arn | ARN of IAM role assumed by the service account |
| service\_account\_name | Name of the service account created |

<!--- END_TF_DOCS --->
