variable "name" {
  type = string
}

variable "subnet_public_ids" {
  type = list(string)
}

variable "http_security_group_id" {
  type = string
}

variable "https_security_group_id" {
  type = string
}

variable "http_redirect_security_group_id" {
  type = string
}

variable "alb_log_bucket_id" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}