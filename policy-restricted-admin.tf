data "aws_iam_policy_document" "restricted_admin" {
  statement {
    effect = "Allow"

    actions = [
      "acm:*",
      "apigateway:*",
      "automation:*",
      "autoscaling:*",
      "aws-marketplace:*",
      "cloudtrail:*",
      "cloudwatch:*",
      "cognito:*",
      "config:*",
      "dynamodb:*",
      "ecr:*",
      "ecs:*",
      "ec2:*",
      "elasticfilesystem:*",
      "elasticache:*",
      "elasticloadbalancing:*",
      "es:*",
      "events:*",
      "glacier:*",
      "health:*",
      "inspector:*",
      "kinesis:*",
      "kms:*",
      "lambda:*",
      "logs:*",
      "rds:*",
      "route53:*",
      "route53domains:*",
      "s3:*",
      "ses:*",
      "shield:*",
      "sns:*",
      "sqs:*",
      "ssm:*",
      "sts:*",
      "swf:*",
      "support:*",
      "trustedadvisor:*",
      "waf:*",
      "waf-regional:*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:AddUserToGroup",
      "iam:AttachGroupPolicy",
      "iam:AttachRolePolicy",
      "iam:CreateAccessKey",
      "iam:CreateGroup",
      "iam:CreateInstanceProfile",
      "iam:CreatePolicy",
      "iam:CreateRole",
      "iam:CreateUser",
      "iam:CreateVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "iam:DeleteAccessKey",
      "iam:DeleteGroup",
      "iam:DeleteInstanceProfile",
      "iam:DeleteLoginProfile",
      "iam:DeletePolicy",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DeleteSSHPublicKey",
      "iam:DeleteUser",
      "iam:DeleteUserPolicy",
      "iam:DeleteVirtualMFADevice",
      "iam:DetachGroupPolicy",
      "iam:DetachRolePolicy",
      "iam:DetachUserPolicy",
      "iam:EnableMFADevice",
      "iam:GenerateCredentialReport",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:Get*",
      "iam:List*",
      "iam:PassRole",
      "iam:PutGroupPolicy",
      "iam:PutRolePolicy",
      "iam:PutUserPolicy",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:RemoveUserFromGroup",
      "iam:UntagRole",
      "iam:UpdateAccessKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = ["*"]
  }
}