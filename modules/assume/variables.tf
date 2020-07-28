variable "assume_role_in_account_id" {
  description = "The Account ID of the remote AWS Account(s) - i.e. which has the role you want to assume"
  type        = string
}

variable "assumed_role_name" {
  type        = string
  description = "The name of the role to be assumed in the remote account"
}

variable "landing_account_id" {
  default     = "335823981503"
  description = "The account ID of the Landing AWS Account"
}

variable "group_name" {
  description = "The name of the IAM group to join users to"
}

variable "users" {
  description = "A list of users"
  type        = list(string)
  default     = []
}

variable "group_effect" {
  description = "The explicit Allow or Deny on the group's policy"
  default     = "Allow"
}

variable "role_policy_arn" {
  description = "(Optional) The ARN of a managed policy"
  default     = ""
}
