# Permissions required by Terraform for enabling GuardDuty
data "aws_iam_policy_document" "mvision_readonly_access" {
  statement {
    sid    = "ReadOnlyAccessManagedPolicy"
    effect = "Allow"

    actions = [
      "a4b:Get*",
      "a4b:List*",
      "a4b:Describe*",
      "a4b:Search*",
      "acm:Describe*",
      "acm:Get*",
      "acm:List*",
      "acm-pca:Describe*",
      "acm-pca:Get*",
      "acm-pca:List*",
      "aesop:Get*",
      "amplify:GetApp",
      "amplify:GetBranch",
      "amplify:GetJob",
      "amplify:GetDomainAssociation",
      "amplify:ListApps",
      "amplify:ListBranches",
      "amplify:ListDomainAssociations",
      "amplify:ListJobs",
      "apigateway:GET",
      "application-autoscaling:Describe*",
      "appmesh:Describe*",
      "appmesh:List*",
      "appstream:Describe*",
      "appstream:Get*",
      "appstream:List*",
      "appsync:Get*",
      "appsync:List*",
      "autoscaling:Describe*",
      "autoscaling-plans:Describe*",
      "autoscaling-plans:GetScalingPlanResourceForecastData",
      "athena:List*",
      "athena:Batch*",
      "athena:Get*",
      "batch:List*",
      "batch:Describe*",
      "cloud9:Describe*",
      "cloud9:List*",
      "clouddirectory:List*",
      "clouddirectory:BatchRead",
      "clouddirectory:Get*",
      "clouddirectory:LookupPolicy",
      "cloudformation:Describe*",
      "cloudformation:Detect*",
      "cloudformation:Get*",
      "cloudformation:List*",
      "cloudformation:Estimate*",
      "cloudformation:Preview*",
      "cloudfront:Get*",
      "cloudfront:List*",
      "cloudhsm:List*",
      "cloudhsm:Describe*",
      "cloudhsm:Get*",
      "cloudsearch:Describe*",
      "cloudsearch:List*",
      "cloudtrail:Describe*",
      "cloudtrail:Get*",
      "cloudtrail:List*",
      "cloudtrail:LookupEvents",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "codebuild:BatchGet*",
      "codebuild:List*",
      "codecommit:BatchGet*",
      "codecommit:Describe*",
      "codecommit:Get*",
      "codecommit:GitPull",
      "codecommit:List*",
      "codedeploy:BatchGet*",
      "codedeploy:Get*",
      "codedeploy:List*",
      "codepipeline:List*",
      "codepipeline:Get*",
      "codestar:List*",
      "codestar:Describe*",
      "codestar:Get*",
      "codestar:Verify*",
      "cognito-identity:Describe*",
      "cognito-identity:Get*",
      "cognito-identity:List*",
      "cognito-identity:Lookup*",
      "cognito-sync:List*",
      "cognito-sync:Describe*",
      "cognito-sync:Get*",
      "cognito-sync:QueryRecords",
      "cognito-idp:AdminGet*",
      "cognito-idp:AdminList*",
      "cognito-idp:List*",
      "cognito-idp:Describe*",
      "cognito-idp:Get*",
      "config:Deliver*",
      "config:Describe*",
      "config:Get*",
      "config:List*",
      "connect:List*",
      "connect:Describe*",
      "connect:GetFederationToken",
      "datasync:Describe*",
      "datasync:List*",
      "datapipeline:Describe*",
      "datapipeline:EvaluateExpression",
      "datapipeline:Get*",
      "datapipeline:List*",
      "datapipeline:QueryObjects",
      "datapipeline:Validate*",
      "dax:BatchGetItem",
      "dax:Describe*",
      "dax:GetItem",
      "dax:ListTags",
      "dax:Query",
      "dax:Scan",
      "directconnect:Describe*",
      "devicefarm:List*",
      "devicefarm:Get*",
      "discovery:Describe*",
      "discovery:List*",
      "discovery:Get*",
      "dlm:Get*",
      "dms:Describe*",
      "dms:List*",
      "dms:Test*",
      "ds:Check*",
      "ds:Describe*",
      "ds:Get*",
      "ds:List*",
      "ds:Verify*",
      "dynamodb:BatchGet*",
      "dynamodb:Describe*",
      "dynamodb:Get*",
      "dynamodb:List*",
      "dynamodb:Query",
      "dynamodb:Scan",
      "ec2:Describe*",
      "ec2:Get*",
      "ec2:SearchTransitGatewayRoutes",
      "ec2messages:Get*",
      "ecr:BatchCheck*",
      "ecr:BatchGet*",
      "ecr:Describe*",
      "ecr:Get*",
      "ecr:List*",
      "ecs:Describe*",
      "ecs:List*",
      "eks:DescribeCluster",
      "eks:DescribeUpdate",
      "eks:ListClusters",
      "eks:ListUpdates",
      "elasticache:Describe*",
      "elasticache:List*",
      "elasticbeanstalk:Check*",
      "elasticbeanstalk:Describe*",
      "elasticbeanstalk:List*",
      "elasticbeanstalk:Request*",
      "elasticbeanstalk:Retrieve*",
      "elasticbeanstalk:Validate*",
      "elasticfilesystem:Describe*",
      "elasticloadbalancing:Describe*",
      "elasticmapreduce:Describe*",
      "elasticmapreduce:List*",
      "elasticmapreduce:View*",
      "elastictranscoder:List*",
      "elastictranscoder:Read*",
      "es:Describe*",
      "es:List*",
      "es:Get*",
      "es:ESHttpGet",
      "es:ESHttpHead",
      "events:Describe*",
      "events:List*",
      "events:Test*",
      "firehose:Describe*",
      "firehose:List*",
      "fsx:Describe*",
      "fsx:List*",
      "gamelift:List*",
      "gamelift:Get*",
      "gamelift:Describe*",
      "gamelift:RequestUploadCredentials",
      "gamelift:ResolveAlias",
      "gamelift:Search*",
      "glacier:List*",
      "glacier:Describe*",
      "glacier:Get*",
      "globalaccelerator:Describe*",
      "globalaccelerator:List*",
      "glue:BatchGetPartition",
      "glue:GetCatalogImportStatus",
      "glue:GetClassifier",
      "glue:GetClassifiers",
      "glue:GetCrawler",
      "glue:GetCrawlers",
      "glue:GetCrawlerMetrics",
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetDataCatalogEncryptionSettings",
      "glue:GetDataflowGraph",
      "glue:GetDevEndpoint",
      "glue:GetDevEndpoints",
      "glue:GetJob",
      "glue:GetJobs",
      "glue:GetJobRun",
      "glue:GetJobRuns",
      "glue:GetMapping",
      "glue:GetPartition",
      "glue:GetPartitions",
      "glue:GetPlan",
      "glue:GetResourcePolicy",
      "glue:GetSecurityConfiguration",
      "glue:GetSecurityConfigurations",
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetTableVersion",
      "glue:GetTableVersions",
      "glue:GetTags",
      "glue:GetTrigger",
      "glue:GetTriggers",
      "glue:GetUserDefinedFunction",
      "glue:GetUserDefinedFunctions",
      "greengrass:Get*",
      "greengrass:List*",
      "guardduty:Get*",
      "guardduty:List*",
      "health:Describe*",
      "health:Get*",
      "health:List*",
      "iam:Generate*",
      "iam:Get*",
      "iam:List*",
      "iam:Simulate*",
      "importexport:Get*",
      "importexport:List*",
      "inspector:Describe*",
      "inspector:Get*",
      "inspector:List*",
      "inspector:Preview*",
      "inspector:LocalizeText",
      "iot:Describe*",
      "iot:Get*",
      "iot:List*",
      "iotanalytics:Describe*",
      "iotanalytics:List*",
      "iotanalytics:Get*",
      "iotanalytics:SampleChannelData",
      "kafka:Describe*",
      "kafka:List*",
      "kafka:Get*",
      "kinesisanalytics:Describe*",
      "kinesisanalytics:Discover*",
      "kinesisanalytics:Get*",
      "kinesisanalytics:List*",
      "kinesisvideo:Describe*",
      "kinesisvideo:Get*",
      "kinesisvideo:List*",
      "kinesis:Describe*",
      "kinesis:Get*",
      "kinesis:List*",
      "kms:Describe*",
      "kms:Get*",
      "kms:List*",
      "lambda:List*",
      "lambda:Get*",
      "lex:Get*",
      "lightsail:GetActiveNames",
      "lightsail:GetBlueprints",
      "lightsail:GetBundles",
      "lightsail:GetCloudFormationStackRecords",
      "lightsail:GetDisk",
      "lightsail:GetDisks",
      "lightsail:GetDiskSnapshot",
      "lightsail:GetDiskSnapshots",
      "lightsail:GetDomain",
      "lightsail:GetDomains",
      "lightsail:GetExportSnapshotRecords",
      "lightsail:GetInstance",
      "lightsail:GetInstanceMetricData",
      "lightsail:GetInstancePortStates",
      "lightsail:GetInstances",
      "lightsail:GetInstanceSnapshot",
      "lightsail:GetInstanceSnapshots",
      "lightsail:GetInstanceState",
      "lightsail:GetKeyPair",
      "lightsail:GetKeyPairs",
      "lightsail:GetLoadBalancer",
      "lightsail:GetLoadBalancerMetricData",
      "lightsail:GetLoadBalancers",
      "lightsail:GetLoadBalancerTlsCertificates",
      "lightsail:GetOperation",
      "lightsail:GetOperations",
      "lightsail:GetOperationsForResource",
      "lightsail:GetRegions",
      "lightsail:GetRelationalDatabase",
      "lightsail:GetRelationalDatabaseBlueprints",
      "lightsail:GetRelationalDatabaseBundles",
      "lightsail:GetRelationalDatabaseEvents",
      "lightsail:GetRelationalDatabaseLogEvents",
      "lightsail:GetRelationalDatabaseLogStreams",
      "lightsail:GetRelationalDatabaseMetricData",
      "lightsail:GetRelationalDatabaseParameters",
      "lightsail:GetRelationalDatabases",
      "lightsail:GetRelationalDatabaseSnapshot",
      "lightsail:GetRelationalDatabaseSnapshots",
      "lightsail:GetResources",
      "lightsail:GetStaticIp",
      "lightsail:GetStaticIps",
      "lightsail:GetTagKeys",
      "lightsail:GetTagValues",
      "lightsail:Is*",
      "lightsail:List*",
      "logs:Describe*",
      "logs:Get*",
      "logs:FilterLogEvents",
      "logs:ListTagsLogGroup",
      "logs:StartQuery",
      "logs:TestMetricFilter",
      "machinelearning:Describe*",
      "machinelearning:Get*",
      "mediaconvert:DescribeEndpoints",
      "mediaconvert:Get*",
      "mediaconvert:List*",
      "mgh:Describe*",
      "mgh:List*",
      "mobileanalytics:Get*",
      "mobilehub:Describe*",
      "mobilehub:Export*",
      "mobilehub:Generate*",
      "mobilehub:Get*",
      "mobilehub:List*",
      "mobilehub:Validate*",
      "mobilehub:Verify*",
      "mobiletargeting:Get*",
      "mq:Describe*",
      "mq:List*",
      "opsworks:Describe*",
      "opsworks:Get*",
      "opsworks-cm:Describe*",
      "organizations:Describe*",
      "organizations:List*",
      "personalize:Describe*",
      "personalize:Get*",
      "personalize:List*",
      "pi:DescribeDimensionKeys",
      "pi:GetResourceMetrics",
      "polly:Describe*",
      "polly:Get*",
      "polly:List*",
      "polly:SynthesizeSpeech",
      "rekognition:CompareFaces",
      "rekognition:Detect*",
      "rekognition:List*",
      "rekognition:Search*",
      "rds:Describe*",
      "rds:List*",
      "rds:Download*",
      "redshift:Describe*",
      "redshift:GetReservedNodeExchangeOfferings",
      "redshift:View*",
      "resource-groups:Describe*",
      "resource-groups:Get*",
      "resource-groups:List*",
      "resource-groups:Search*",
      "robomaker:BatchDescribe*",
      "robomaker:Describe*",
      "robomaker:List*",
      "route53:Get*",
      "route53:List*",
      "route53:Test*",
      "route53domains:Check*",
      "route53domains:Get*",
      "route53domains:List*",
      "route53domains:View*",
      "route53resolver:Get*",
      "route53resolver:List*",
      "s3:Get*",
      "s3:List*",
      "s3:Head*",
      "sagemaker:Describe*",
      "sagemaker:GetSearchSuggestions",
      "sagemaker:List*",
      "sagemaker:Search",
      "sdb:Get*",
      "sdb:List*",
      "sdb:Select*",
      "secretsmanager:List*",
      "secretsmanager:Describe*",
      "secretsmanager:GetResourcePolicy",
      "securityhub:Describe*",
      "securityhub:Get*",
      "securityhub:List*",
      "serverlessrepo:List*",
      "serverlessrepo:Get*",
      "serverlessrepo:SearchApplications",
      "servicecatalog:List*",
      "servicecatalog:Scan*",
      "servicecatalog:Search*",
      "servicecatalog:Describe*",
      "servicediscovery:Get*",
      "servicediscovery:List*",
      "servicequotas:GetAssociationForServiceQuotaTemplate",
      "servicequotas:GetAWSDefaultServiceQuota",
      "servicequotas:GetRequestedServiceQuotaChange",
      "servicequotas:GetServiceQuota",
      "servicequotas:GetServiceQuotaIncreaseRequestFromTemplate",
      "servicequotas:ListAWSDefaultServiceQuotas",
      "servicequotas:ListRequestedServiceQuotaChangeHistory",
      "servicequotas:ListRequestedServiceQuotaChangeHistoryByQuota",
      "servicequotas:ListServices",
      "servicequotas:ListServiceQuotas",
      "servicequotas:ListServiceQuotaIncreaseRequestsInTemplate",
      "ses:Get*",
      "ses:List*",
      "ses:Describe*",
      "shield:Describe*",
      "shield:Get*",
      "shield:List*",
      "snowball:Get*",
      "snowball:Describe*",
      "snowball:List*",
      "sns:Get*",
      "sns:List*",
      "sns:Check*",
      "sqs:Get*",
      "sqs:List*",
      "sqs:Receive*",
      "ssm:Describe*",
      "ssm:Get*",
      "ssm:List*",
      "states:List*",
      "states:Describe*",
      "states:GetExecutionHistory",
      "storagegateway:Describe*",
      "storagegateway:List*",
      "sts:Get*",
      "swf:Count*",
      "swf:Describe*",
      "swf:Get*",
      "swf:List*",
      "tag:Get*",
      "transfer:Describe*",
      "transfer:List*",
      "transfer:TestIdentityProvider",
      "transcribe:Get*",
      "transcribe:List*",
      "trustedadvisor:Describe*",
      "waf:Get*",
      "waf:List*",
      "waf-regional:List*",
      "waf-regional:Get*",
      "workdocs:Describe*",
      "workdocs:Get*",
      "workdocs:CheckAlias",
      "worklink:Describe*",
      "worklink:List*",
      "workmail:Describe*",
      "workmail:Get*",
      "workmail:List*",
      "workmail:Search*",
      "workspaces:Describe*",
      "xray:BatchGet*",
      "xray:Get*",
    ]

    resources = ["*"]
  }
}

# Create mvision role in landing account
module "add_mvision_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.landing_account_id}"
  role_name                  = "${var.terraform_aws_security_name}"
  landing_account_id         = "${var.mvision_account_id}"
  role_policy                = "${data.aws_iam_policy_document.mvision_readonly_access.json}"
  role_principal_identifiers = ["arn:aws:iam::${var.mvision_account_id}:root"]
  role_principal_type        = "AWS"
}
