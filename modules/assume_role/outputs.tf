output "landing_policy" {
  value = aws_iam_policy.landing
}

output "destination_role" {
  value = aws_iam_role.destination
}

output "destination_policy" {
  value = aws_iam_policy.destination
}
