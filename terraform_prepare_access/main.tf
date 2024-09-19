data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


resource "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}


data "aws_iam_policy_document" "github_actions_oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      values   = ["repo:Latyn4ik/dynamic_rds:*"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}


resource "aws_iam_role" "github_actions_oidc" {
  name               = "github_oidc_role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_oidc.json
}




# resource "aws_iam_role_policy_attachment" "rds_1" {
#   role       = aws_iam_role.github_actions_oidc.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
# }

# resource "aws_iam_role_policy_attachment" "test_only" {
#   role       = aws_iam_role.github_actions_oidc.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }


data "aws_iam_policy_document" "github_actions_rds_snapshots_and_kms" {
  statement {
    actions = [
      "rds:CreateDBSnapshot",
      "rds:DescribeDBSnapshots",
      "rds:CopyDBSnapshot"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey"
    ]

    resources = [
      "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
    ]
  }

}


resource "aws_iam_policy" "github_actions_rds_snapshots_and_kms" {
  name        = "github-actions-rds-snapshots-and-kms"
  policy      = data.aws_iam_policy_document.github_actions_rds_snapshots_and_kms.json
}

resource "aws_iam_role_policy_attachment" "github_actions_rds_snapshots_and_kms" {
  role       = aws_iam_role.github_actions_oidc.name
  policy_arn = aws_iam_policy.github_actions_rds_snapshots_and_kms.arn
}