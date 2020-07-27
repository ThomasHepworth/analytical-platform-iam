# Role module

This folder contains a Terraform module that defines the infra that:

* creates a role in a remote AWS account
* that an authorized user/role in the Landing AWS account can AssumeRole into. (That user/role in the Landing AWS account is created by the [assume module](../assume) )
