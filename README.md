# Analytical Platform IAM

Analytical Platform IAM config

Terraform definitions of:

* IAM Users for the Landing AWS Account - for AWS users of the Analytical Platform
* Users are added to Groups, which are given Policies, so that they have permissions
* Roles & Policies for other AWS Accounts that allows these users to switch into those accounts - [INIT-ROLES](init-roles/README.md)

CI: this repo's terraform is applied using a [defined CodePipeline](pipeline/README.md)

### AWS Account setup

Before you can use any of these terraform modules, an AWS account needs an IAM role, which is in: [INIT-ROLES](init-roles/README.md)

## Usage

As an example of usage, we'll create a user, then put it in a new "AWS Glue Administrators" group in the Landing AWS Account. We'll also create a role with relevant permissions in the dev aws account for members of that group to assume.

### User creation

Typically a dev or data engineer will need a user account. This is an IAM User in the Landing (AWS) account, with which you can [assume role]() into the other AP AWS accounts.

To create yourself an IAM User, add a aws_iam_user resource to [users.tf](users.tf) e.g.:

```hcl
resource "aws_iam_user" "bob" {
  name          = "bob@digital.justice.gov.uk"
  force_destroy = true
}
```

Create a PR with this change (and you probably want to add it to some existing groups in this same PR - see next section).

Ask for this PR to be reviewed, and then merge it.

### First login

Following the creation of your user (give it a few minutes for the AWS CodeBuild pipeline to run) ask someone from the 'restricted admin' group to send you your AWS console password.

Access the AWS console here: https://analytical-platform-landing.signin.aws.amazon.com/console

* Account ID: `analytical-platform-landing`
* IAM username: `bob@digital.justice.gov.uk` (the name you specified in users.tf)
* Password: (was sent to you)

Log-in and it'll prompt you to change your password. It needs to be: minimum 16 characters, including uppercase, a number and a symbol from: `(!@#$%^&*()_+-=[]{}|')`.

You MUST set-up MFA - it is required to be able to switch role. To set-up MFA:

1. In AWS console's top bar, click your username and then "My Security Credentials"
2. Click button "Assign MFA device"
3. etc... (Full instructions are [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_enable.html))

NB: Before you can switch role you must also log out of the AWS Console and back in again, so that you've used MFA during log-in.

Note: Managing users with Terraform (e.g. passwords) is still at best clunky, so we decided that admins should do this with the AWS console instead.

### Existing groups

Your user can't do much until you add it to a group, which are setup to let the user 'assume' into a role with an attached policy (i.e. permissions). Existing groups are listed in the `assume-*.tf` files in this repo - one for each AWS account.

* [assume-data.tf](assume-data.tf) - 'data' account - includes existing alpha & dev environments
* [assume-landing.tf](assume-landing.tf) - landing / IAM account
* [assume-dev.tf](assume-dev.tf) - future dev environment
* [assume-prod.tf](assume-prod.tf) - future prod environment

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
  source = "modules/role"
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
  source = "modules/assume"

  assumed_role_name = "${var.glue_admins_name}-${local.dev}"

  assume_role_in_account_id = [
    "${var.ap_accounts["dev"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.glue_admins_name}-${local.dev}"

  users = [
    "${aws_iam_user.bob.name}",
    "${aws_iam_user.alice.name}",
  ]
}

module "add_glue_admins_role_in_dev" {
  source = "modules/role"
  providers = {
    aws = "aws.dev"
  }

  role_name                 = "${var.glue_admins_name}-${local.dev}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.glue_admins.json}"
}
```


### Authenticating

#### AWS console

Once you've [created your user](#User-creation) you have access to the [AWS console for the Landing AWS Account](https://analytical-platform-landing.signin.aws.amazon.com/console).

From this account you can click on your user menu and then "switch role" to a role in another AWS account. e.g. to account `mojanalytics` as `restricted-admin-data`.

Alternatively just use these links:
* https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=read-only-data&displayName=read-only@data
* https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=restricted-admin-data&displayName=restricted-admin@data
* https://signin.aws.amazon.com/switchrole?account=analytical-platform-landing&roleName=read-only-landing&displayName=read-only@landing
* https://signin.aws.amazon.com/switchrole?account=analytical-platform-landing&roleName=restricted-admin-landing&displayName=restricted-admin@landing
* https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=data-engineers-hmcts&displayName=data-engineers-hmcts@mojanalytics
* https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=data-engineers-prisons&displayName=data-engineers-prisons@mojanalytics
* https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=data-engineers-probation&displayName=data-engineers-probation@mojanalytics
* https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=data-engineers-corporate&displayName=data-engineers-corporate@mojanalytics

Please use the 'read-only' roles by default - only use 'restricted-admin' when you need to make a change.

#### AWS CLI using profile

It is convenient to configure an assumed role as a 'profile' in your ~/.aws/credentials file. See:

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html

This works for aws cli, but note **it doesn't work for terraform commands**. For terraform, use assume-role - see below.

#### AWS CLI using assume-role

In the AWS console (Landing account) you can create an access key, which can be used with the AWS cli tool `aws`

[awscli]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
[aws profile]: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

If you want to run tests or apply terraform config from your local machine you'll first need to authenticate

##### Prerequisites

* Firstly ensure you have an existing `IAM` user account in the Landing account. See [Usage](#usage)

* Ensure you have installed the [awscli][awscli]

* **Optional**: Create a profile for your landing user account. See [Creating an AWS Profile][aws profile]

**Note** you can set this profile as your default by assigning to the `AWS_PROFILE` environment variable

__Request temporary credentials to assume the appropriate role in the desired account__:

```bash
aws sts assume-role --role-arn "arn:aws:iam::593291632749:role/restricted-admin-data" --role-session-name data-session
```

__Set temporary credentials as environment variables__:

```bash
export AWS_ACCESS_KEY_ID=ASIAX........
export AWS_SECRET_ACCESS_KEY=0vwDrU5..........
export AWS_SESSION_TOKEN="FQoGZXIvYXdzEHQaDHBH......."
```

__Did it work?__

```bash
aws sts get-caller-identity
```

**Note** If using credentials to apply terraform config, you'll need to pass the flag `-lock=false` as the role you're assuming will not have
permissions to access the lock table.. i.e. `terraform plan -lock=false`

__When finished!__:

Your credentials are temporary and will expire after 1 hour.  You'll need to repeat the process to be able to authenticate after this time

Unset your credentials:

```bash
unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
```

## Tests

This project is tested using the [Kitchen Terraform](https://github.com/newcontext-oss/kitchen-terraform) testing harness. Admittedly Kitchen is not ideally suited for IAM because [Inspec](https://www.inspec.io/docs/reference/resources/#aws-resources) has limited support.

__TODO__:

Remove Kitchen in favour of [awspec](https://github.com/k1LoW/awspec)

__Tests__:

Install dependencies

```bash
bundle install
```

Lint

```bash
rubocop test/integration/analytical-platform-iam/controls
```

Set your AWS profile to be the landing account and assume-role into the same account as the objects you're testing. (Kitchen will create AWS resources).

Ensure there are no fixtures remaining from previous test runs

```bash
bundle exec kitchen destroy
```

Create resources

```bash
bundle exec kitchen converge
```

Run tests

```bash
bundle exec kitchen verify
```

Tidy up

```bash
bundle exec kitchen destroy
```
