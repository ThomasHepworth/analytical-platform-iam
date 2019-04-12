data "aws_iam_policy_document" "read_market_place_subscriptions" {
  statement {
    effect = "Allow"

    actions = [
      "aws-marketplace:ViewSubscriptions",
    ]

    resources = ["*"]
  }
}
