# Analytical Platform IAM pipeline

Pipeline (defined in Terraform config) that applies the IAM Terraform (as defined in `..`) in both Landing and remote AWS accounts.

## Usage

* A push to the master branch of this repository will trigger the AWS CodePipeline.
* This clones the repository and passes it to the AWS Codebuild service.
* Codebuild (which is an ubuntu 18.04 container in this instance) runs a terraform plan and stores the plan file into the S3 Bucket created for the pipeline.
* The plan file should be reviewed and approved/rejected within Codepipeline.
* If approved, another codebuild envrionment will spin up, retrieve and apply the plan file stored in the S3 bucket.

The commands run within the codebuild stages are in the [buildspec-plan.yml](buildspec-plan.yml) and [buildspec-apply.yml](buildspec-apply.yml) files.

### Diagram

![Image](iam-pipeline.png?raw=true)

### Checking pipeline progress

The progress of the pipeline execution can be checked in the AWS Console in "AWS CodePipeline" > "Pipelines" in the `landing` AWS account (be sure to be in the Ireland region).

## Developer guide

The pipeline runs as role `landing-iam-role`, which has permissions defined in an inline policy, edited in [../init-roles/iam.tf](../init-roles/iam.tf).
