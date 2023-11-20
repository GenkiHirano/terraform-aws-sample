provider "aws" {
  region = var.aws_region
  // TODO: terraform cloudで管理するようにする
  access_key = "sample_access_key"
  secret_key = "sample_secret_key"
}
