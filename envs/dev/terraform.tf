terraform {
  // TODO: 環境変数で管理するように修正
  required_version = "~> 1.6.3"
  required_providers {
    aws = {
      // TODO: 環境変数で管理するように修正
      version = "~> 5.0"
      source  = "hashicorp/aws"
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
