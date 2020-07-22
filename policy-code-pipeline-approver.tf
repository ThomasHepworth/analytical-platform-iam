data "aws_iam_policy_document" "code_pipeline_approver" {
  statement {
    effect = "Allow"

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

    resources = [
      "*",
    ]
  }
}
