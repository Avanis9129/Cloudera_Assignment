###############Define cross account IAM Role####################
#data "aws_iam_policy_document" "cross-account-access" {
#  source_json = file("./policies/aws-cb-policy.json")  # Path to your JSON policy file
#}

resource "aws_iam_policy" "cross-account-policy" {
  name        = "aws-cdp-cross-account-policy"
  description = "IAM Policy for cross account"
  #policy      = data.aws_iam_policy_document.cross-account-access.json
  policy      = file("${path.module}/policies/aws-cb-policy.json")
}

resource "aws_iam_role" "cross_account_role" {
  name = "CrossAccountRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${CDP_ACCOUNT_ID}:root"  # Replace with the external account ID
        },
        Action = "sts:AssumeRole",
        Condition = {
          StringEquals = {
            "sts:ExternalId" = "${CDP_EXTERNAL_ID}"  # Replace with your external ID
          }
        }
      }
    ]
  })
}
resource "aws_iam_policy_attachment" "cross-account-policy-attachment" {
  name       = "policy-attachment"
  policy_arn = aws_iam_policy.cross-account-policy.arn
  roles      = [aws_iam_role.cross_account_role.name]
}
#  policy = [
#    aws_iam_policy.cross-account-policy.arn,
#  ]


################Define roles for Onboarding CDP users and groups for AWS cloud storage (no RAZ)#######################

resource "aws_iam_policy" "datasci-policy" {
  name        = "aws-cdp-datasci-policy-s3access"
  description = "IAM Policy 4"
  policy      = file("${path.module}/policies/aws-cdp-datasci-policy-s3access.json")
}

resource "aws_iam_role" "DATASCI" {
  name = "DATASCI_ROLE	"
  assume_role_policy = file("${path.module}/policies/aws-cdp-idbroker-role-trust-policy.json")  # Path to your trust policy JSON file
  policy = [
    aws_iam_policy.datasci-policy.arn,
    aws_iam_policy.bucket-access-policy.arn,
  ]
}

resource "aws_iam_policy_attachment" "datasci-policy-attachment" {
  name       = "datasci-policy-attachment"
  policy_arn = aws_iam_policy.datasci-policy.arn
  roles      = [aws_iam_role.DATASCI.name]
}
resource "aws_iam_policy" "dataeng-policy" {
  name        = "aws-cdp-dataeng-policy-s3access"
  description = "IAM Policy 2"
  policy      = file("${path.module}/policies/aws-cdp-dataeng-policy-s3access.json")
}

resource "aws_iam_role" "DATAENG" {
  name = "DATAENG_ROLE	"
  assume_role_policy = file("${path.module}/policies/aws-cdp-idbroker-role-trust-policy.json")  # Path to your trust policy JSON file
  policy = [
    aws_iam_policy.dataeng-policy.arn,
    aws_iam_policy.bucket-access-policy.arn,
  ]
}



################Define roles for AWS cloud storage#######################


resource "aws_iam_policy" "bucket-access-policy" {
  name        = "aws-cdp-bucket-access-policy"
  description = "IAM Policy 1"
  policy      = file("${path.module}/policies/aws-cdp-bucket-access-policy.json")
}


resource "aws_iam_policy" "datalake-policy" {
  name        = "aws-cdp-datalake-admin-s3-policy"
  description = "IAM Policy 3"
  policy      = file("${path.module}/policies/aws-cdp-datalake-admin-s3-policy.json")
}

resource "aws_iam_policy" "idbroker-assume-policy" {
  name        = "aws-cdp-idbroker-assume-role-policy"
  description = "IAM Policy 5"
  policy      = file("${path.module}/policies/aws-cdp-idbroker-assume-role-policy.json")
}

resource "aws_iam_policy" "log-policy" {
  name        = "aws-cdp-log-policy"
  description = "IAM Policy 6"
  policy      = file("${path.module}/policies/aws-cdp-log-policy.json")
}

resource "aws_iam_policy" "ranger-audit-policy" {
  name        = "aws-cdp-ranger-audit-s3-policy"
  description = "IAM Policy 7"
  policy      = file("${path.module}/policies/aws-cdp-ranger-audit-s3-policy.json")
}

resource "aws_iam_policy" "datalake-backup-policy" {
  name        = "aws-datalake-backup-policy"
  description = "IAM Policy 8"
  policy      = file("${path.module}/policies/aws-datalake-backup-policy.json")
}

resource "aws_iam_policy" "datalake-restore-policy" {
  name        = "aws-datalake-restore-policy"
  description = "IAM Policy 9"
  policy      = file("${path.module}/policies/aws-datalake-restore-policy.json")
}

#creating role with trust policy

resource "aws_iam_role" "IDBROKER" {
  name = "IDBROKER_ROLE"
  assume_role_policy = file("${path.module}/policies/aws-cdp-ec2-role-trust-policy.json")  # Path to your trust policy JSON file

  # Attach multiple IAM policies to the role
  policy = [
    aws_iam_policy.idbroker-assume-policy.arn,
    aws_iam_policy.log-policy.arn,
  ]  
}

resource "aws_iam_role" "LOG" {
  name = "LOG_ROLE"
  assume_role_policy = file("${path.module}/policies/aws-cdp-ec2-role-trust-policy.json")  # Path to your trust policy JSON file

  policy = [
    aws_iam_policy.datalake-restore-policy.arn,
    aws_iam_policy.log-policy.arn,
  ]
}

resource "aws_iam_role" "RANGER_AUDIT" {
  name = "RANGER_AUDIT_ROLE"
  assume_role_policy = file("${path.module}/policies/aws-cdp-idbroker-role-trust-policy.json")  # Path to your trust policy JSON file
  policy = [
    aws_iam_policy.datalake-restore-policy.arn,
    aws_iam_policy.datalake-backup-policy.arn,
    aws_iam_policy.ranger-audit-policy.arn,
    aws_iam_policy.bucket-access-policy.arn,
  ]
}

resource "aws_iam_role" "DATALAKE_ADMIN" {
  name = "DATALAKE_ADMIN_ROLE"
  assume_role_policy = file("${path.module}/policies/aws-cdp-idbroker-role-trust-policy.json")  # Path to your trust policy JSON file
  policy = [
    aws_iam_policy.datalake-restore-policy.arn,
    aws_iam_policy.datalake-backup-policy.arn,
    aws_iam_policy.datalake-policy.arn,
    aws_iam_policy.bucket-access-policy.arn,
  ]
}

# Define the IAM instance profile and add the role to it
resource "aws_iam_instance_profile" "LOG_ROLE" {
  name = "LOG_ROLE"
  roles = [aws_iam_role.LOG_ROLE.name]
}

resource "aws_iam_instance_profile" "IDBROKER_ROLE" {
  name = "IDBROKER_ROLE"
  roles = [aws_iam_role.IDBROKER_ROLE.name]
}



