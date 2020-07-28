# `assume-role`

This module creates role in a destination account, and allows a list of users in the Landing account to assume into it.

It does this by:

- adding an IAM role to be assumed
- attaching the IAM policy that allows each user to assume the role in the named destination account
- allowing the attachment of an optional, named policy to the list of named users

## Inputs

| Name                      | Description                                         | Type           | Default | Required |
| ------------------------- | --------------------------------------------------- | -------------- | ------- | :------: |
| `aws_iam_policy_document` | AWS IAM Policy Document to add to the list of users | `any`          | n/a     |   yes    |
| `destination_role_name`   | Role name in the destination account                | `string`       | n/a     |   yes    |
| `users`                   | List of users to add the policy to                  | `list(string)` | n/a     |   yes    |

## Outputs
