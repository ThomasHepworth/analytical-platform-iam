data "aws_iam_policy_document" "read_only" {
  statement {
    effect = "Allow"

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

    resources = ["*"]
  }
}
