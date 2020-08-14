# Analytical Platform IAM

Defines IAM Users in the Analytical Platform's Landing AWS Account and gives them permissions to switch role (AssumeRole) into other Analytical Platform AWS accounts.

The Landing Account is for defining IAM Users and their permissions. The security of IAM is paramount therefore:

- this IAM configuration is isolated in its own AWS Account, away from the rest of the platform - don't put other things in this account!
- only a small number of people can modify it
- deployment is automated and stored in code to be auditable

In addition, since the Analytical Platform is spread over multiple other AWS Accounts, it is convenient for each engieer to have one set of user credentials, rather than having one for each AWS Account.

## Table of Contents

- [Analytical Platform IAM](#analytical-platform-iam)
  - [Table of Contents](#table-of-contents)
  - [Contents of this repo](#contents-of-this-repo)
    - [IAM Terraform definitions](#iam-terraform-definitions)
    - [IAM Pipeline](#iam-pipeline)
    - [`init-roles`](#init-roles)
  - [AWS Account setup](#aws-account-setup)
  - [Usage](#usage)
    - [User creation](#user-creation)
    - [First login](#first-login)
    - [Authenticating](#authenticating)
      - [AWS CLI](#aws-cli)
      - [AWS Console](#aws-console)
  - [Administration](#administration)

## Contents of this repo

### IAM Terraform definitions

Terraform definitions, that are applied in multiple AWS Accounts.

In the Landing AWS Account:

- IAM Users - for use by administrators of the Analytical Platform
- Those Users are added to Groups, which are given Policies, that allow them to:
  - switch role (AssumeRole) into certain roles in certain remote accounts
  - manage their own creds

In remote AWS accounts:

- Roles that Users in the Landing Account switch role (AssumeRole) into

### IAM Pipeline

Terraform definition of an AWS CodePipeline, continuously deploys the IAM Terraform code.

Folder: [`pipeline`](pipeline/README.md)

### `init-roles`

Terraform definitions of roles to be created in remote AWS accounts.

Folder: [`init-roles`](init-roles/README.md)

## AWS Account setup

Before you can apply the "IAM Terraform definitions", every AWS account that it [specifies](vars/landing.tfvars) needs the `init-roles` terraform applied - see: [`init-roles`](init-roles/README.md)

## Usage

The following example:

- Creates an "AWS Glue Administrator" group in the Landing account
- Creates a role with relevant permissions in the dev AWS account for members of that group to assume

### User creation

File: [`users.tf`](users.tf)

All users require an account in the landing account. Add user module, with your details.

```hcl
module "bob" {
  source      = "./modules/user"
  email       = "bob@digital.justice.gov.uk"
  tags        = local.tags
  group_names = [aws_iam_group.users.name]
}
```

Add yourself the relevant groups in [`teams.tf`](teams.tf). For example, if you are part of the `data_first_data_engineering_team` then you would amend the following users list:

```hcl
module "data_first_data_engineering_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.george.name,
    aws_iam_user.sam.name,
  ]
}
```

Create a Pull Request (PR) with this change. The PR will automatically request a review from the relevant team.

Your PR will then be reviwed. Once it has been merged (by yourself) the AWS Code Pipeline will then be triggered. The Adminstrators will need to approve the change in the pipeline for the changes to be applied.

Administrators should see the [administrator-guide](documentation/ADMINISTRATOR_GUIDE.md) for more information.

### First login

Once you have received your AWS console password from the administrators, login as follows.

Access the AWS console here: <https://analytical-platform-landing.signin.aws.amazon.com/console>

- Account ID: `analytical-platform-landing`
- IAM username: `bob@digital.justice.gov.uk` (the name you specified in users.tf)
- Password: (was sent to you)

Log-in and it will prompt you to change your password. The password needs to be: minimum 16 characters, including uppercase, a number and a symbol from: `!@#$%^&*()_+-=[]{}|'`.

(If it does not prompt you to change your password then you'll need to come back to this after you've setup MFA and logged out and in again)

You MUST set-up MFA - it is required to be able to switch role. To set-up MFA:

1. In AWS console's top bar, click your username and then "My Security Credentials"
2. Click button "Assign MFA device"
3. etc... (Full instructions are [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_enable.html))

Now you MUST log out of the AWS Console and back in again, so that it registers you've used MFA, before you can do anything else.

### Authenticating

#### AWS CLI

See the [AWS CLI guide](documentation/AWS-CLI.md) for instructions on setting up your cli tool to authenticate with AWS.

#### AWS Console

Once you've [created your user](#User-creation) you have access to the [AWS console for the Landing AWS Account](https://analytical-platform-landing.signin.aws.amazon.com/console).

From this account you can click on your user menu and then "switch role" to a role in another AWS account. e.g. to account `mojanalytics` as `restricted-admin`.

Alternatively use these links:

- [read-only@data](https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=read-only&displayName=read-only@data)
- [restricted-admin@data](https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=restricted-admin&displayName=restricted-admin@data)
- [billing-viewer@data](https://signin.aws.amazon.com/switchrole?account=mojanalytics&roleName=billing-viewer&displayName=billing-viewer@data)
- [read-only@landing](https://signin.aws.amazon.com/switchrole?account=analytical-platform-landing&roleName=read-only&displayName=read-only@landing)
- [restricted-admin@landing](https://signin.aws.amazon.com/switchrole?account=analytical-platform-landing&roleName=restricted-admin&displayName=restricted-admin@landing)

Please use the 'read-only' roles by default - only use 'restricted-admin' when you need to make a change.

## Administration

If you need to amend the current roles please see the [administration guide](documentation/ADMINISTRATOR_GUIDE.md)
