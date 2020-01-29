data "aws_iam_policy_document" "billing_viewer" {
  statement {
    sid    = "ViewBillingAndCostManagement"
    effect = "Allow"

    actions = [
      "aws-portal:View*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "DenyAccountSettings"
    effect = "Deny"

    actions = [
      "aws-portal:*Account",
    ]

    resources = ["*"]
  }
}
