data "aws_iam_policy_document" "transit_kms_key_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid       = "Allow use of the key for target AWS account"
    actions   = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.target_aws_account_id}:root"]
    }
  }

  statement {
    sid       = "Allow target account to administer the key"
    actions   = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.target_aws_account_id}:root"]
    }
  }
}


resource "aws_kms_key" "transit" {
  description             = "Transit KMS key for encrypting RDS snapshots"

  key_usage = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7

  policy = data.aws_iam_policy_document.transit_kms_key_policy.json
}

resource "aws_kms_alias" "transit_rds_key" {
  name          = "alias/transit_rds_key"
  target_key_id = aws_kms_key.transit.key_id
}
