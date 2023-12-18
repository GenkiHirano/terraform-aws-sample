variable "name" {
  type = string
}

variable "subnet_private_ids" {
  type = list(string)
}

variable "rds_security_group_id" {
  type = string
}

variable "redis_security_group_id" {
  type = string
}

variable "kms_key_arn" {
  type = string
}



