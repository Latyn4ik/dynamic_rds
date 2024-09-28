data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


module "github-oidc" {
  source = "../modules/terraform-aws-github-oidc-provider"

  repositories              = ["repo:Latyn4ik/dynamic_rds:*"]
  oidc_role_attach_policies = [aws_iam_policy.github_actions_rds_snapshots_and_kms.arn]

  providers = {
    aws = aws.source
  }
}


resource "aws_iam_policy" "github_actions_rds_snapshots_and_kms" {
  name   = "github-actions-rds-snapshots-and-kms"
  policy = data.aws_iam_policy_document.github_actions_rds_snapshots_and_kms.json

  provider = aws.source
}


data "aws_iam_policy_document" "github_actions_rds_snapshots_and_kms" {
  statement {
    actions = [
      # "rds:CreateDBSnapshot",
      # "rds:DescribeDBSnapshots",
      # "rds:CopyDBSnapshot",
      # "rds:AddTagsToResource",
      # "rds:ListTagsForResource",
      # "rds:DeleteDBSnapshot",
      # "rds:ModifyDBSnapshotAttribute"

      "rds:CreateDBClusterSnapshot",
      "rds:DescribeDBClusterSnapshots",
      "rds:CopyDBClusterSnapshot",
      "rds:AddTagsToResource",
      "rds:ListTagsForResource",
      "rds:DeleteDBClusterSnapshot",
      "rds:ModifyDBClusterSnapshotAttribute"
    ]

    resources = ["arn:aws:rds:*:${data.aws_caller_identity.current.account_id}:*"]
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

    resources = [
      "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
    ]
  }
}