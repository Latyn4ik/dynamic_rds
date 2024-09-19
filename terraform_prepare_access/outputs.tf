output "github_actions_oidc_role_arn" {
  value = aws_iam_role.github_actions_oidc.arn
}

### KMS ###
output "transit_kms_key_id" {
  value = aws_kms_key.transit.id
}

output "transit_kms_key_arn" {
  value = aws_kms_alias.transit_rds_key.arn
}
