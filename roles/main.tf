data "aws_iam_policy_document" "bucket-access" {
  source_json = file("./policies/aws-cdp-bucket-access-policy.json")  # Path to your JSON policy file
}

data "aws_iam_policy_document" "dataeng" {
  source_json = file("./policies/aws-cdp-dataeng-policy-s3access.json")
}

data "aws_iam_policy_document" "datalake-admin" {
  source_json = file("./policies/aws-cdp-datalake-admin-s3-policy.json")
}

data "aws_iam_policy_document" "datasci" {
  source_json = file("./policies/aws-cdp-datasci-policy-s3access.json")
}

data "aws_iam_policy_document" "idbroker-assume" {
  source_json = file("./policies/aws-cdp-idbroker-assume-role-policy.json")
}

data "aws_iam_policy_document" "log" {
  source_json = file("./policies/aws-cdp-log-policy.json")
}

data "aws_iam_policy_document" "ranger-audit" {
  source_json = file("./policies/aws-cdp-ranger-audit-s3-policy.json")
}

data "aws_iam_policy_document" "datalake-backup" {
  source_json = file("./policies/aws-datalake-backup-policy.json")
}

data "aws_iam_policy_document" "datalake-restore" {
  source_json = file("./policies/aws-datalake-restore-policy.json")
}

resource "aws_iam_policy" "bucket-access-policy" {
  name        = "aws-cdp-bucket-access-policy"
  description = "IAM Policy 1"
  policy      = data.aws_iam_policy_document.bucket-access.json
}

resource "aws_iam_policy" "dataeng-policy" {
  name        = "aws-cdp-dataeng-policy-s3access"
  description = "IAM Policy 2"
  policy      = data.aws_iam_policy_document.dataeng.json
}

resource "aws_iam_policy" "datalake-policy" {
  name        = "aws-cdp-datalake-admin-s3-policy"
  description = "IAM Policy 3"
  policy      = data.aws_iam_policy_document.datalake.json
}

resource "aws_iam_policy" "datasci-policy" {
  name        = "aws-cdp-datasci-policy-s3access"
  description = "IAM Policy 4"
  policy      = data.aws_iam_policy_document.datasci.json
}

resource "aws_iam_policy" "idbroker-assume-policy" {
  name        = "aws-cdp-idbroker-assume-role-policy"
  description = "IAM Policy 5"
  policy      = data.aws_iam_policy_document.idbroker-assume.json
}

resource "aws_iam_policy" "log-policy" {
  name        = "aws-cdp-log-policy"
  description = "IAM Policy 6"
  policy      = data.aws_iam_policy_document.log.json
}

resource "aws_iam_policy" "ranger-audit-policy" {
  name        = "aws-cdp-ranger-audit-s3-policy"
  description = "IAM Policy 7"
  policy      = data.aws_iam_policy_document.ranger-audit.json
}

resource "aws_iam_policy" "datalake-backup-policy" {
  name        = "aws-datalake-backup-policy"
  description = "IAM Policy 8"
  policy      = data.aws_iam_policy_document.datalake-backup.json
}

resource "aws_iam_policy" "datalake-restore-policy" {
  name        = "aws-datalake-restore-policy"
  description = "IAM Policy 9"
  policy      = data.aws_iam_policy_document.datalake-restore.json
}

#creating role with trust policy

resource "aws_iam_role" "IDBROKER" {
  name = "IDBROKER_ROLE"
  assume_role_policy = file("./policies/aws-cdp-ec2-role-trust-policy.json")  # Path to your trust policy JSON file

  # Attach multiple IAM policies to the role
  policy = [
    aws_iam_policy.idbroker-assume-policy.arn,
    aws_iam_policy.log-policy.arn,
  ]  
}

resource "aws_iam_role" "LOG" {
  name = "LOG_ROLE"
  assume_role_policy = file("./policies/aws-cdp-ec2-role-trust-policy.json")  # Path to your trust policy JSON file

  policy = [
    aws_iam_policy.datalake-restore-policy.arn,
    aws_iam_policy.log-policy.arn,
  ]
}

resource "aws_iam_role" "RANGER_AUDIT" {
  name = "RANGER_AUDIT_ROLE"
  assume_role_policy = file("./policies/aws-cdp-idbroker-role-trust-policy.json")  # Path to your trust policy JSON file
  policy = [
    aws_iam_policy.datalake-restore-policy.arn,
    aws_iam_policy.datalake-backup-policy.arn,
    aws_iam_policy.ranger-audit-policy.arn,
    aws_iam_policy.bucket-access-policy.arn,
  ]
}

resource "aws_iam_role" "DATALAKE_ADMIN" {
  name = "DATALAKE_ADMIN_ROLE"
  assume_role_policy = file("./policies/aws-cdp-idbroker-role-trust-policy.json")  # Path to your trust policy JSON file
  policy = [
    aws_iam_policy.datalake-restore-policy.arn,
    aws_iam_policy.datalake-backup-policy.arn
    aws_iam_policy.datalake-policy.arn,
    aws_iam_policy.bucket-access-policy.arn,
  ]
}

