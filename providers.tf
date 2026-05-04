terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-982005835619-us-west-2-an"
    key            = "amsgitops/terraform-test-infra/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Name         = "CodeKeeperService"
      RepositoryId = "amsgitops/terraform-test-infra"
      Environment  = var.environment
      ManagedBy    = "Terraform"
    }
  }
}
