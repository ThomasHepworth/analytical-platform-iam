variable "destination_role_name" {
  description = "The name of the role to create in the destination account"
  type        = string
}

variable "user_names" {
  description = "A list of user names to attach the assume role policy to "
  type        = list(string)
}

variable "user_arns" {
  description = "A list of user ARNs to allow to access the role. The users should match those in user_names"
  type        = list(string)
}

variable "managed_policies" {
  description = "(Optional) A set of AWS managed policy ARNs to attach to the user(s)"
  type        = list(string)
  default     = []
}

variable "aws_iam_policy_documents" {
  description = "(Optional) A map of policy document names & AWS IAM Policy Documents to add to the group of users"
  type        = map
  default     = {}
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map
}

variable "destination_account_name" {
  description = "(optional) name of the destination account. This adds an option suffix to the assume-role name"
  type        = string
  default     = ""
}
