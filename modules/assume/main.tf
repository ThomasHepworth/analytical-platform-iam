locals {
  roles = "${join(",\n", formatlist("arn:aws:iam::%s:role/%s", var.assume_role_in_account_id, var.assumed_role_name))}"
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "${var.group_effect}"
    actions   = ["${var.group_effect == "Allow" ? "sts:AssumeRole" : "*"}"]
    resources = ["${var.group_effect == "Allow" ? local.roles : "*"}"]
  }
}

## IAM Group
resource "aws_iam_group" "group" {
  name = "${var.group_name}"
}

## Add users to the group
resource "aws_iam_group_membership" "group_membership" {
  group = "${aws_iam_group.group.name}"
  name  = "group-membership"
  users = ["${var.users}"]
}

resource "aws_iam_policy" "assume" {
  policy = "${data.aws_iam_policy_document.policy.json}"
  name   = "assume-role-${var.group_name}"
}

## Attach policy to group
resource "aws_iam_policy_attachment" "assume" {
  name       = "${aws_iam_group.group.name}"
  policy_arn = "${aws_iam_policy.assume.arn}"
  groups     = ["${aws_iam_group.group.name}"]
}
