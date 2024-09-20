output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = module.github-oidc.oidc_provider_arn
}

output "github_oidc_role_arn" {
  description = "CICD GitHub role"
  value       = module.github-oidc.oidc_role_arn
}

### KMS ###
output "transit_kms_key_id" {
  value = aws_kms_key.transit.id
}

output "transit_kms_key_arn" {
  value = aws_kms_alias.transit_rds_key.arn
}
