data "aws_iam_policy_document" "assume" {
  statement {
    effect = "Allow"

    principals {
      identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
      type        = "AWS"
    }

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"

      values = [
        "true",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "assume_with_condition" {
  statement {
    effect = "Allow"

    principals {
      identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
      type        = "AWS"
    }

    condition {
      test     = "StringLike"
      variable = "sts:ExternalId"

      values = [
        "${var.external_id}",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create role in remote account
resource "aws_iam_role" "role" {
  name               = "${var.role_name}"
  assume_role_policy = "${var.external_id == "" ? data.aws_iam_policy_document.assume.json : data.aws_iam_policy_document.assume_with_condition.json}"

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
