terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.27.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=2.0.0"
    }
  }
}
