data "aws_iam_policy_document" "allow_assume" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.this.arn]
  }
}

resource "aws_iam_policy" "assume" {
  provider = aws.source
  name     = "assume-role-${var.destination_role_name}"
  policy   = data.aws_iam_policy_document.allow_assume.json
}

resource "aws_iam_role" "allow_assume" {
  provider           = aws.source
  name               = "allow-assume-${var.destination_role_name}"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

output "allow_assume_role" {
  value = aws_iam_role.allow_assume
}

resource "aws_iam_policy_attachment" "this" {
  provider   = aws.source
  name       = "attachment-${var.destination_role_name}"
  users      = var.users
  roles      = [aws_iam_role.allow_assume.name]
  policy_arn = aws_iam_policy.assume.arn
}
