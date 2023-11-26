terraform {
  required_version = "~> 1.6.3"
  required_providers {
    aws = {
      version = "~> 5.0"
      source = "hashicorp/aws"
    }

    sops = {
      source = "carlpett/sops"
    }
  }
  cloud {
    organization = "genki-hirano-private"
    hostname     = "app.terraform.io"

    workspaces {
      name = "aws-terraform-dev"
    }
  }
}
