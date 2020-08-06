provider "aws" {}

variable "email" {
  type = string
}

variable "tags" {
  type        = map
  description = "A map of tags to apply to all resources"
}

variable "group_names" {
  type    = list(string)
  default = []
}

# TODO: tag users
resource "aws_iam_user" "user" {
  name = var.email
  # tags          = var.tags
  force_destroy = true
}

output "user" {
  value = aws_iam_user.user
}

output "arn" {
  value = aws_iam_user.user.arn
}

output "name" {
  value = aws_iam_user.user.name
}

resource "aws_iam_user_group_membership" "membership" {
  count  = length(var.group_names)
  user   = aws_iam_user.user.name
  groups = var.group_names
}
