variable "assume_role_in_account_id" {
  description = "The ID of the account with the role you want to assume"
  type        = "list"
}

variable "landing_account_id" {
  default     = "335823981503"
  description = "The Landing account ID"
}

variable "assumed_role_name" {
  description = "The name of the role to be assumed in the remote account"
}

variable "group_name" {
  description = "The name of the IAM group to join users to"
}

variable "users" {
  description = "A list of users"
  type        = "list"
}
