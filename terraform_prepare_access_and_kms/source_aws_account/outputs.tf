
output "source_aws_region" {
  description = "AWS region of source account where deployed Aurora RDS cluster"
  value       = var.source_aws_region
}
output "github_oidc_role_arn" {
  description = "CICD GitHub role"
  value       = module.github-oidc.oidc_role_arn
}

### RDS Aurora Cluster ###
output "source_rds_aurora_cluster_id" {
  value = module.aurora_instance.cluster_id
}

### KMS ###
output "transit_kms_key_arn" {
  value = aws_kms_key.transit.arn
}