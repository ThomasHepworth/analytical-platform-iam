variable "name" {}
variable "pipeline_github_owner" {}
variable "pipeline_github_repo" {}
variable "pipeline_github_branch" {}
variable "tf_plan_timeout" {
  default = 5
}
variable "tf_apply_timeout" {
  default = "20"
}

variable "codebuild_compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}
variable "codebuild_image" {
  default = "aws/codebuild/standard:1.0"
}
