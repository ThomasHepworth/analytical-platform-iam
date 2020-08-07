# Administrator Guide

This is a guide to Analytical Platform IAM administration:

* policies
* walk-through of making changes to Analytical Platform IAM

## Policies on IAM Permissions

We make decisions on what permissions users have according to business needs. But you should also bear in mind these guiding principles:

* Team roles. Users are aggregated by their team, which are assigned an AWS Role that gives permissions to perform their usual day to day work. The aim is to balance between two aims:
  * minimizing the permissions given (the related security principles are: fine-grained permissions, least privilege, minimize blast radius, and for data it's the 'need to know' basis)
  * clarity and convenience of giving groups of users all the same permissions

* Users can also 'elevate' permissions. In addition to their team role, users can occasionally use an AWS Role that has wider permissions. This could be to build new AWS infrastructure, or try out a new AWS service. By having a separate role for this, used only when needed, it means that at other times the 'blast radius' is reduced. (This security technique is called 'privilege bracketing' or 'just in time administration'.)

* Users should access AWS only via the Landing Account. This means:
  * IAM Users exist only in the Landing AWS Account - not in the other AWS Accounts. The Landing Account is dedicated to this purpose, for minimum attack surface.
  * IAM Users are created with terraform in this repo. This allows changes in the PR to be reviewed & audited, and changes applied automatically (for security and reliability)
  * To access the AWS Console, users log into the Landing Account first, before switching to a role in the appropriate target account
  * On the command-line, users use their AccessKey for their Landing Account's IAM User, and then sts:AssumeRole to a role in the relevant target account.

* Determining appropriate user permissions is the responsibility of each team themselves. This avoids unnecessary coupling between teams, which can cause delays authorizing permissions. However we all agree to abide by these principles.

### Data Engineers

Data Engineer permissions are approved by their teams' staff who are Grade 6 or Grade 7.

## Approve and Apply the Terraform Change

To approve and apply an IAM change, an admin (from the 'Code pipeline approver group') should:

* Login to AP's Landing AWS account and switch to [restricted-admin@landing](https://signin.aws.amazon.com/switchrole?account=analytical-platform-landing&roleName=restricted-admin-landing&displayName=restricted-admin@landing)
* In CodePipeline, in region `eu-west-1`, go to the pipeline `iam-pipeline`
* On the 'Plan' step, check the output of 'terraform plan' looks right
* On the 'Approve' step, click 'Review' and 'Approve'
* Wait 2 minutes to ensure the 'Apply' step succeeds

For a new user:

* in IAM, find the new User and:
  * in tab "Security credentials" "Console password" select "Manage"
  * under "Console access" select "Enable"
  * under "Require password reset" *check* the box
  * select "Apply"
* Email the user their AWS console password and the link to: [First login](../README.md/#first-login)

### Editing Policies

#### Policies

Policies are designed to allow one team to perform the same role/job. Therefore when editing or creating new roles it should be for a team.

The exception to this is the Data Engineering Team Leads team. This role gives leasd extra permissions to exploratation of new services & to approve code pipelines.

### AWS Managed Policies

Where possible and appropreate, use AWS managed policies. These are often pre-built with a particular purpose in mind, for example running a Glue Job.

#### Roles

The main portion of this repository provisions roles in remote AWS accounts and gives permisions to a trusted set of users to assume those roles

The example module below, attaches a set of managed policies and a single named policy called `prison-data-engineer` to the destination role.

Users passed in through `user_names` & `user_arns`, are the only people allowed to assume that role.

Providers specify the accounts that the module has access to. If you need to create a role in the `prod` account, the destination should specify `prod`.

```hcl
module "prison_data_engineer" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name = "prison-data-engineer"
  user_names            = module.prison_data_engineering_team.user_names
  user_arns             = module.prison_data_engineering_team.user_arns

  managed_policies = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
    "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess",
    "arn:aws:iam::aws:policy/AWSLakeFormationDataAdmin",
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodePipelineApproverAccess",
    "arn:aws:iam::aws:policy/AWSCodePipelineReadOnlyAccess",
  ]

  aws_iam_policy_documents = {
    "prison_data_engineer" = data.aws_iam_policy_document.prison_data_engineer,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.data
  }
}
```
