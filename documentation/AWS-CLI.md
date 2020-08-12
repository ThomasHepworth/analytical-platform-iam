# AWS CLI

This guide is users settings up AWS CLI for the first time.

it is useful if you require access to AWS via the command line or other programatic tools.

- [AWS CLI](#aws-cli)
  - [AWS CLI Setup](#aws-cli-setup)
    - [AWS CLI: Required Tools](#aws-cli-required-tools)
      - [Windows](#windows)
      - [Linux](#linux)
      - [MacOS](#macos)
  - [Access Key Setup](#access-key-setup)
  - [AWS Vault](#aws-vault)
    - [AWS-Vault: Required Tools](#aws-vault-required-tools)
    - [AWS-Vault: Installation](#aws-vault-installation)
  - [AWS profiles](#aws-profiles)

## AWS CLI Setup

### AWS CLI: Required Tools

- `aws-cli`
- homebrew (MacOS only)

#### Windows

[Follow the AWS guide to installing cliv2 on Windows](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html#cliv2-windows-prereq)

#### Linux

[Follow the AWS guide to installing the v2 CLI guide on Linux](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install)

#### MacOS

- [Install homebrew](https://brew.sh/)
- `brew install awscli`

## Access Key Setup

To setup an AWS access key on your machine:

- Login to the AWS Console ([see the README for more information](../README.md))
- Select your username in the top-bar and in this drop-down menu select "My Security Credentials". (If you've switched to another account or role, first you'll have to select "Back to <your_username>")
- In the section "Access keys for CLI, SDK, & API access" select "Create access key"
- It should say "Your new access key is now available". Leave this on your screen while you configure these details into you command-line in the following step.
- Run `aws configure`, with the suggested profile name `landing` and put in your Access Key ID and Secret Access Key seen on the AWS Console:

   ```bash
   $ aws configure --profile landing
   AWS Access Key ID [None]: AKIA...
   AWS Secret Access Key [None]: Ti2d7...
   Default region name [None]: eu-west-1
   Default output format [None]:
   ```

   This will add credentials to `~/.aws/credentials` and default region to `~/.aws/config`.

This profile is required, but not much use on its own. You only use this landing account as a hop, from which you switch to a role in a destination account. To use the AWS CLI with the destination account & role, you have a couple of options - see the following sections.

*Note:* this method works for running aws cli commands, but **it doesn't work for terraform commands**. For terraform, use assume-role or AWS Vault - see below.

## AWS Vault

An alternative approach to using the raw aws-cli is to use [AWS-Vault by 99-designs](https://github.com/99designs/aws-vault).

Secrets are stored in a platform specific secrets store, rather than on disk. See [Vaulting Backends](https://github.com/99designs/aws-vault#vaulting-backends) for more information.

### AWS-Vault: Required Tools

- `aws-cli`
- `aws-vault`

### AWS-Vault: Installation

For full, OS specific instructions please see the [AWS-Vault README](https://github.com/99designs/aws-vault#installing).

- Once you have installed aws-vault, you will then need to setup a source profile. Enter the credentials for the landing account when prompted.

   ```shell
   # Store AWS credentials for the "landing" profile
   $ aws-vault add landing
   Enter Access Key Id: ABDCDEFDASDASF
   Enter Secret Key: %%%
   ```

- You will then be able to ask AWS STS which account you are logged into:

```shell
aws-vault exec landing -- aws sts get-caller-identity
```

- To be able to access resources in another account you will need to add your MFA serial to the landing config. The MFA ARN can be copied from the AWS Console [here](https://console.aws.amazon.com/iam/home#/security_credentials), under "Assigned MFA device".

   ```shell
   ~/.aws/config
   [profile landing]
   mfa_serial=<insert_your_mfa_arn_here>
   ```

- For each role you want to switch to, you will need a profile setup in `~/.aws/config`. See the examples in AWS profiles below.

## AWS profiles

You will need to create an AWS profile that tells your relevant tool to login to another account, after using the AWS STS service to aquire temporary credentials.

The following lines will grant you read-only access to resources in the landing account.

```ini
# ~/.aws/config
[profile readonly-landing]
region=eu-west-1
role_arn=arn:aws:iam::335823981503:role/read-only-landing
source_profile=landing
```

The following lines will grant you restricted admin to both the data and landing account.
```ini
# ~/.aws/config
[profile restricted-landing]
region = eu-west-1
role_arn=arn:aws:iam::335823981503:role/restricted-admin-landing
source_profile=landing

[profile restricted-data]
region = eu-west-1
role_arn=arn:aws:iam::593291632749:role/restricted-admin-data
source_profile=landing
```

Test everything is working with:
```shell
aws-vault exec restricted-data aws s3 ls
```