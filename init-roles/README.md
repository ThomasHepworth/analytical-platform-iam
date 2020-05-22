# INIT-ROLES

Defines some IAM roles that are needed in every AWS account in the system. These roles are the minimum that allows the Landing AWS Account to setup what it needs.

* iam.tf - Role "landing-iam-role" (used by the "iam" CodePipeline to create roles that users can AssumeRole into)
* terraform-infrastructure-role - Role "terraform-infrastructure" that can be assumed by:
  * Landing AWS account user/roles (which also need permission via ../modules/assume),
    which is the way that developers will administer this AWS account
  * CodeBuild, which will ...(to be described)

## Why

When the [role module](../modules/role) is invoked it attempts to assume the role created by this module and create the
IAM resources it defines.

**Note**: This module must be invoked in all new and existing AWS accounts at least once before the main portion of this repository's
resources will work.

## Usage

**Note**: Requires an account with the necessary permissions to the target account

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```

__Local state only__
