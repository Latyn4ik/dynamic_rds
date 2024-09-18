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
      values   = ["repo:Latyn4ik/dynamic_rds/*"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}


resource "aws_iam_role" "github_actions_oidc" {
  name               = "github_oidc_role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_oidc.json
}




resource "aws_iam_role_policy_attachment" "rds_1" {
  role       = aws_iam_role.github_actions_oidc.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "test_only" {
  role       = aws_iam_role.github_actions_oidc.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
