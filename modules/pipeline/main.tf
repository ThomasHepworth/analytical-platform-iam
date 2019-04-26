##### Codepipeline #####
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.name}-ap-codepipeline-bucket"
  acl    = "private"
}

resource "aws_iam_role" "codepipeline_role" {
  name = "${var.name}-codepipeline-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.name}-codepipeline-policy"
  role = "${aws_iam_role.codepipeline_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.codepipeline_bucket.arn}",
        "${aws_s3_bucket.codepipeline_bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.name}"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  artifact_store {
    location = "${aws_s3_bucket.codepipeline_bucket.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner  = "${var.pipeline_github_owner}"
        Repo   = "${var.pipeline_github_repo}"
        Branch = "${var.pipeline_github_branch}"
      }
    }
  }

  stage {
    name = "Plan"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["plan_output"]
      version          = "1"

      configuration = {
        ProjectName = "${aws_codebuild_project.build_project_tf_plan.name}"
      }
    }
  }

  stage {
    name = "Approve"

    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
    }
  }

  stage {
    name = "Apply"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["plan_output"]
      version         = "1"

      configuration = {
        ProjectName = "${aws_codebuild_project.build_project_tf_apply.name}"
      }
    }
  }
}


#####  Codebuild #####
resource "aws_iam_role" "codebuild_role" {
  name = "${var.name}-codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_policy" {
  role = "${aws_iam_role.codebuild_role.name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.codepipeline_bucket.arn}",
        "${aws_s3_bucket.codepipeline_bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "s3:*Object",
      "Resource": "${aws_s3_bucket.codepipeline_bucket.arn}/tfplan"
    }
  ]
} 
POLICY
}

resource "aws_codebuild_project" "build_project_tf_plan" {
  name          = "${var.name}-tf-plan"
  description   = "Build project to run infrastructure terraform plan"
  build_timeout = "${var.tf_plan_timeout}"
  service_role  = "${aws_iam_role.codebuild_role.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "${var.codebuild_compute_type}"
    image                       = "${var.codebuild_image}"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      "name"  = "TF_IN_AUTOMATION"
      "value" = "true"
    }

    environment_variable {
      "name"  = "PLAN_BUCKET"
      "value" = "${aws_s3_bucket.codepipeline_bucket.id}"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "pipeline/buildspec-plan.yml"
  }

  tags = {
    "environment-name" = "landing"
  }
}

resource "aws_codebuild_project" "build_project_tf_apply" {
  name          = "${var.name}-tf-apply"
  description   = "Build project to apply infrastructure terraform plan"
  build_timeout = "${var.tf_apply_timeout}"
  service_role  = "${aws_iam_role.codebuild_role.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "${var.codebuild_compute_type}"
    image                       = "${var.codebuild_image}"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      "name"  = "TF_IN_AUTOMATION"
      "value" = "true"
    }

    environment_variable {
      "name"  = "PLAN_BUCKET"
      "value" = "${aws_s3_bucket.codepipeline_bucket.id}"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "pipeline/buildspec-apply.yml"
  }

  tags = {
    "environment-name" = "landing"
  }
}