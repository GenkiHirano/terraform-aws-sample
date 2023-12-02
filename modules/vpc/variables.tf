variable "name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "port" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_public_cidr_block" {
  type = string
}

variable "subnet_private_cidr_block" {
  type = string
}

variable "route_table_cidr_block" {
  type = string
}

variable "security_group_cidr_block" {
  type = string
}