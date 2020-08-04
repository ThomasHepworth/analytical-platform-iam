variable "aws_iam_policy_documents" {
  description = "(Optional) A map of policy document names & AWS IAM Policy Documents to add to the group of users"
  type        = map
  default     = {}
}

variable "users" {
  description = "(Optional) List of users to add the policy to"
  type        = list(string)
  default     = []
}

variable "destination_role_name" {
  description = "Role name in the destination account"
  type        = string
}

variable "managed_policies" {
  type        = list(string)
  description = "(Optional) A set of AWS managed policy ARNs to attach to the user(s)"
  default     = []
}

variable "tags" {
  description = "A map of tags for resources"
  type        = map
}
