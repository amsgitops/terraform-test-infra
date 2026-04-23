terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      RepositoryId = "amsgitops/terraform-test-infra"
      Environment  = var.environment
      ManagedBy    = "Terraform"
    }
  }
}
