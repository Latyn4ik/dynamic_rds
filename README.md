# dynamic_rds

## Dynamic RDS Aurora Cluster Setup Pipeline

This GitHub Actions pipeline dynamically sets up an RDS Aurora cluster by performing the following steps:

1. **Encrypted Snapshot Creation**: A minimal set of resources is deployed, and an encrypted snapshot of an existing Aurora cluster is created.
2. **Re-encryption with Custom KMS Key**: The snapshot is re-encrypted with a custom KMS key and shared with the target AWS account.
3. **Snapshot Migration**: The snapshot is migrated from one AWS account and region to another target account and region.
4. **Aurora Cluster Deployment**: The pipeline deploys a new Aurora cluster in the target account and region using the copied snapshot.
5. **Terraform Management**: All necessary Terraform files (`backend.tf`, `provider.tf`) are dynamically generated and managed to ensure smooth deployment.

This setup allows for streamlined RDS Aurora cluster creation and management with Terraform.


## Setup guide:
1. Go to Settings -> Environments -> New environment -> fill name: **rds_destroy** -> Configure environment
2. Click on new created environment -> Required reviewers -> Add up to 5 more reviewers -> Save protection rules
3. Go to **/terraform_prepare_access_and_kms/source_aws_account/**
4. Configure backend.tf and variables.tf files with your values for described variables and parameters. If needed you can modify parameters for RDS Aurora cluster in  file: rds_aurora_cluster.tf
5. Run terraform init and terraform apply
6. Go to **/terraform_prepare_access_and_kms/target_aws_account/**
7. Configure backend.tf and variables.tf files with your values for described variables and parameters.
8. Run terraform init and terraform apply
9. Configure all Environment variables in file: dynamic_rds/.github/workflows/main.yml. ll possible configuration parameters located in top of file.