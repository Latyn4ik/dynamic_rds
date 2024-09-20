output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = aws_iam_openid_connect_provider.github.arn
}

output "oidc_role_arn" {
  description = "CICD GitHub role"
  value       = try(aws_iam_role.github_oidc[0].arn, "")
}