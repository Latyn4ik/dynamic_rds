data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


module "github-oidc" {
  source = "../modules/terraform-aws-github-oidc-provider"

  repositories              = ["repo:Latyn4ik/dynamic_rds:*"]
  oidc_role_attach_policies = [aws_iam_policy.github_actions_rds_snapshots_and_kms.arn]
}


resource "aws_iam_policy" "github_actions_rds_snapshots_and_kms" {
  name   = "github-actions-rds-snapshots-and-kms"
  policy = data.aws_iam_policy_document.github_actions_rds_snapshots_and_kms.json
}


data "aws_iam_policy_document" "github_actions_rds_snapshots_and_kms" {
  statement {
    actions = ["rds:*"]

    resources = ["*"]
  }

  statement {
    actions = ["iam:*"]

    resources = ["*"]
  }

  statement {
    actions = ["secretsmanager:*"]

    resources = ["*"]
  }


  statement {
    actions = ["ec2:*"]

    resources = ["*"]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncryptTo",
      "kms:ReEncryptFrom",
      "kms:List*",
      "kms:Get*",
      "kms:Describe*",
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]

    resources = ["arn:aws:kms:*"]
  }

  statement {
    sid = "TfstateBucket"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:PutObject",
      "s3:GetObject"
    ]

    resources = ["arn:aws:s3:::*"]
  }

  statement {
    sid = "TfstateLockTable"
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem"
    ]

    resources = ["arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/*"]
  }
}
