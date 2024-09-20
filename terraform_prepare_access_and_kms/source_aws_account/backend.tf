terraform {
  backend "s3" {
    bucket = "test-oidc-access-prepare-tfstate-source-account"
    key    = "dynamic_rds/terraform.tfstate"
    region = "eu-central-1"
  }
}