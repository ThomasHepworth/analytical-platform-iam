module "master-pipeline" {
  source = "../modules/pipeline"
  
  name = "iam-pipeline"
  pipeline_github_repo = "analytical-platform-iam"
  pipeline_github_owner = "ministryofjustice"
  pipeline_github_branch = "master"
}
