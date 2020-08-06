variable "users" {
  type        = list(string)
  description = "List of user names to add to the group"
}

output "users" {
  value = data.aws_iam_user.users
}

data "aws_iam_user" "users" {
  count     = length(var.users)
  user_name = element(var.users, count.index)
}

output "user_names" {
  value = var.users
}

output "user_arns" {
  value = data.aws_iam_user.users.*.arn
}
