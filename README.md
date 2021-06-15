# cloud-platform-terraform-irsa

This module is created for teams in order to connect AWS roles to our live clusters using IRSA (IAM Roles for Service Accounts). 

## Usage

```hcl
module "irsa" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=0.0.1"

  environment-name       = "example-env"
  team_name              = "cloud-platform"
  infrastructure-support = "example-team@digtal.justice.gov.uk"
  application            = "exampleapp"
  sqs_name               = "examplesqsname"
}

```

<!--- BEGIN_TF_DOCS --->


<!--- END_TF_DOCS --->
