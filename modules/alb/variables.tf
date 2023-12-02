variable "env" {
  type = string
}

variable "service" {
  type = string
}

variable "subnet_public_ids" {
  type = list(string)
}

variable "subnet_app_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "public_alb_security_groups" {
  type = list(string)
}

variable "api_ssl_arn" {
  type = string
}
