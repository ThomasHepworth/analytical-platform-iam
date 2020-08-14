module "data_engineering_leads" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name = "data-engineering-leads"
  user_names            = module.data_engineering_leads_team.user_names
  user_arns             = module.data_engineering_leads_team.user_arns

  managed_policies = [
    "arn:aws:iam::aws:policy/AWSCodePipelineApproverAccess",
    "arn:aws:iam::aws:policy/AWSCodePipelineReadOnlyAccess",
  ]

  aws_iam_policy_documents = {
    "pipeline_approver" = data.aws_iam_policy_document.code_pipeline_approver,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.landing
  }
}

data "aws_iam_policy_document" "code_pipeline_approver" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "codepipeline:GetPipeline",
      "codepipeline:GetPipelineState",
      "codepipeline:GetPipelineExecution",
      "codepipeline:ListActionExecutions",
      "codepipeline:ListPipelineExecutions",
      "codepipeline:ListPipelines",
      "codepipeline:PutApprovalResult",
      "codepipeline:RetryStageExecution",
      "codepipeline:StartPipelineExecution",
      "codepipeline:StopPipelineExecution",
    ]
  }
}
