# Assume special IAM-Role (../iam-role) in remote account to create roles and policies
provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "arn:aws:iam::${var.assume_role_in_account_id}:role/${var.landing_iam_role}"
  }
}

data "aws_iam_policy_document" "assume" {
  statement {
    effect = "Allow"

    principals {
      identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
      type        = "AWS"
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create role in remote account
resource "aws_iam_role" "role" {
  name               = "${var.role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume.json}"

  tags {
    business-unit = "${var.tags["business-unit"]}"
    application   = "${var.tags["application"]}"
    is-production = "${var.tags["is-production"]}"
    owner         = "${var.tags["owner"]}"
  }
}

# Allow attaching a role policy document to resulting role
resource "aws_iam_role_policy" "role_policy" {
  policy = "${var.role_policy}"
  role   = "${aws_iam_role.role.id}"
  name   = "${var.role_name}"
  count  = "${signum(length(var.role_policy))}"
}

# Allow attaching role policy by specifying the policy's arn.  Useful for managed policies
resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  policy_arn = "${var.role_policy_arn}"
  role       = "${aws_iam_role.role.name}"
  count      = "${signum(length(var.role_policy_arn))}"
}
