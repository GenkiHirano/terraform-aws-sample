variable "env" {
  type = string
}

variable "service" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "subnet_public_cidr" {
  type = string
}

variable "subnet_private_cidr" {
  type = string
}
