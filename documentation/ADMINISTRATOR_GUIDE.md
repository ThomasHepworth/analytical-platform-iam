# Administrator Guide

This guide walks new Administrators through approving changes to the Analytical Platform IAM

## Approve and Apply the Terraform Change

To approve and apply an IAM change, an admin (from the 'restricted admin group') should:

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
* Email the user their AWS console password and the link to: [First login](#first-login)

### New/editing groups

#### Variables

Group names should be held in variables (and we may well refer to it several times), so we'll put it in [variables.tf](variables.tf). For example we'll create a group called `glue-admins`
You would add something like below to [variables.tf](variables.tf)

```hcl
## Glue Admins

variable "glue_admins_name" {
  default = "glue-admins"
}
```

#### Policies

Create a policy for a *purpose* and attach it to multiple user groups. This is better than a group having one big policy, because it means you're likely to end up putting lots of users in bigger groups, which is against the 'principle of least privilege'. You can iterate on policies that already exist in this repository or create a policy document from scratch.

Policy files should be prefixed with `policy-` for clarity. For example `policy-glue-admins.tf`

To use a managed policy instead, you can refer to the policy by using it's ARN with the parameter `role_policy_arn`

```hcl
module "add_glue_admins_role_in_dev" {
  source = "./modules/role"
  providers = {
    aws = "aws.dev"
  }

  role_name                 = "${var.glue_admins_name}-${local.dev}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy_arn           = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
}
```

#### Roles and Groups

The main portion of this repo provisions roles in remote aws accounts and groups where members can assume those roles.
To do this you need to invoke both the `assume` and `role` modules. The `assume` module defines the group, it's members
and the relationship with the role in the remote account. The `role` module defines the role and attached policies that
get created in the remote account.

```hcl
module "assume_glue_admins_in_dev" {
  source = "./modules/assume"

  assumed_role_name = "${var.glue_admins_name}-${local.dev}"
  assume_role_in_account_id = var.ap_accounts["dev"]
  landing_account_id = var.landing_account_id
  group_name         = "${var.glue_admins_name}-${local.dev}"

  users = [
    "${aws_iam_user.bob.name}",
    "${aws_iam_user.alice.name}",
  ]
}

module "add_glue_admins_role_in_dev" {
  source = "./modules/role"
  providers = {
    aws = "aws.dev"
  }

  role_name                 = "${var.glue_admins_name}-${local.dev}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.glue_admins.json}"
}
```
