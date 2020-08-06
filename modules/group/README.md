# Group

This module crates a fake group resource, which outputs a list of user ARNs and user_names which can be easily consumed by other resources.

It takes the place of the `aws_iam_group` resources, as the data sources are indeterministic and always produce a plan.
