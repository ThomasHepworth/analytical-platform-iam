variable "region" {
  default = "eu-west-1"
}

variable "source_account_id" {
  description = "The Landing account ID"
  type        = string
}

variable "landing_iam_role" {
  default     = "landing-iam-role"
  description = "The role to assume to manage roles in remote accounts"
}

variable "role_name" {
}

variable "role_policy" {
  description = "The main policy to attach to the role"
  default     = ""
}

variable "role_policy_arn" {
  description = "The ARN of the main policy"
  default     = ""
}

variable "tags" {
  type = map(string)
}
