output "github_oidc_role_arn" {
  description = "CICD GitHub role"
  value       = module.github-oidc.oidc_role_arn
}

### KMS ###
output "transit_kms_key_arn" {
  value = aws_kms_key.transit.arn
}
