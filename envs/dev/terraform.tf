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
    organization = "blueish"
    hostname     = "app.terraform.io"

    workspaces {
      name = "spotbite-infra-dev"
    }
  }
}
