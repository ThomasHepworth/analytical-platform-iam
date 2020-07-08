data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    sid       = "assumeLandingIamRole"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::*:role/landing-iam-role"]
  }
}

# A CodePipeline that plan/applies the terraform found in the master branch of this (IAM) repo
module "master-pipeline" {
  source = "github.com/ministryofjustice/analytical-platform-pipeline"

  name                   = "iam-pipeline"
  pipeline_github_repo   = "analytical-platform-iam"
  pipeline_github_owner  = "ministryofjustice"
  pipeline_github_branch = "main"
  codebuild_policy       = "${data.aws_iam_policy_document.codebuild_policy.json}"
}
