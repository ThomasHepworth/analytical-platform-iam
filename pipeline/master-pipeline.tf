data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    sid       = "assumeLandingIamRole"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::*:role/landing-iam-role"]
  }
}

module "master-pipeline" {
  source = "github.com/ministryofjustice/analytical-platform-pipeline"

  name                   = "iam-pipeline"
  pipeline_github_repo   = "analytical-platform-iam"
  pipeline_github_owner  = "ministryofjustice"
  pipeline_github_branch = "master"
  codebuild_policy       = "${data.aws_iam_policy_document.codebuild_policy.json}"
}
