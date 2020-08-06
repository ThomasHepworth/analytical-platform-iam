data "aws_iam_policy_document" "read_only" {
  # statement {
  #   sid       = "DenyAccessToSensitiveItems"
  #   effect    = "Deny"
  #   resources = ["*"]
  #   actions = [
  #     "cloudformation:GetTemplate",
  #     "dynamodb:GetItem",
  #     "dynamodb:BatchGetItem",
  #     "dynamodb:Query",
  #     "dynamodb:Scan",
  #     "ec2:GetConsoleOutput",
  #     "ec2:GetConsoleScreenshot",
  #     "ecr:BatchGetImage",
  #     "ecr:GetAuthorizationToken",
  #     "ecr:GetDownloadUrlForLayer",
  #     "kinesis:Get*",
  #     "lambda:GetFunction",
  #     "logs:GetLogEvents",
  #     "s3:GetObject",
  #     "sdb:Select*",
  #     "sqs:ReceiveMessage"
  #   ]
  # }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudtrail:Describe*",
      "cloudtrail:Get*",
      "cloudtrail:List*",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "ec2:Describe*",
      "ec2:Get*",
      "elasticloadbalancing:Describe*",
      "events:Describe*",
      "events:Get*",
      "events:List*",
      "iam:Get*",
      "iam:List*",
      "iam:SimulatePrincipalPolicy",
      "logs:Describe*",
      "logs:Get*",
      "route53:Get*",
      "route53:List*",
      "route53domains:Get*",
      "route53domains:List*",
      "s3:Get*",
      "s3:List*",
    ]
  }

  statement {
    sid       = "ViewBillingAndCostManagement"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["aws-portal:View*"]
  }

  statement {
    sid       = "DenyAccountSettings"
    effect    = "Deny"
    resources = ["*"]
    actions   = ["aws-portal:*Account"]
  }
}
