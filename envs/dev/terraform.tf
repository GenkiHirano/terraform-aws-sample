terraform {
  required_providers {
    aws = {
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
