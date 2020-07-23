data "aws_iam_policy_document" "billing_viewer" {
  statement {
    sid       = "ViewBillingAndCostManagement"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "aws-portal:View*",
    ]
  }

  statement {
    sid       = "DenyAccountSettings"
    effect    = "Deny"
    resources = ["*"]

    actions = [
      "aws-portal:*Account",
    ]
  }
}
