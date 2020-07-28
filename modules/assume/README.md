# AWS Assume Module

This module:

- creates a named group
- adds users to that group
- lets the group perform an AssumeRole into a remote AWS account with a particular role

The AssumeRole also requires that the remote account has the role setup to allow the AssumeRole too, and this is done with the [../role/] module.
