output "github_oidc_role_arn" {
  description = "CICD GitHub role"
  value       = module.github-oidc.oidc_role_arn
}

### KMS ###
output "dynamic_rds_kms_key_id" {
  value = aws_kms_key.dynamic.id
}

output "dynamic_rds_kms_key_arn" {
  value = aws_kms_alias.dynamic_rds_key.arn
}