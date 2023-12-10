variable "name" {
  type = string
}

variable "subnet_private_ids" {
  type = list(string)
}

variable "security_groups_id" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "load_balancer_target_group_arn" {
  type = string
}

