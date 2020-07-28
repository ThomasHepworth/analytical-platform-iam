variable "aws_iam_policy_document" {
  description = "AWS IAM Policy Document to add to the group of users"
}

variable "users" {
  type        = list(string)
  description = "List of users to add the policy to"
}

variable "destination_role_name" {
  type        = string
  description = "Role name in the destination account"
}

variable "existing_policy_arn" {
  type        = string
  description = "(Optional) An existing policy ARN to attach to the user(s)"
  default     = ""
}

variable "tags" {
  type        = map
  description = "A map of tags for resources"
}
