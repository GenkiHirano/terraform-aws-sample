variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "service" {
  type    = string
  default = "aimoney"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.10.0.0/16"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "subnet_public_cidr" {
  type    = string
  default = "10.10.64.0/20"
}

variable "subnet_private_cidr" {
  type    = string
  default = "10.10.80.0/20"
}
