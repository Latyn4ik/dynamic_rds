data "aws_iam_policy_document" "dynamic_kms_key_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}


resource "aws_kms_key" "dynamic" {
  description = "Dynamic KMS key for encrypting RDS snapshots"

  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7

  policy = data.aws_iam_policy_document.dynamic_kms_key_policy.json
}

resource "aws_kms_alias" "dynamic_rds_key" {
  name          = "alias/dynamic_rds_key"
  target_key_id = aws_kms_key.dynamic.key_id
}
