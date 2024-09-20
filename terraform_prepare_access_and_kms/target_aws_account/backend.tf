terraform {
  backend "s3" {
    bucket = "test-oidc-access-prepare-tfstate-target-account"
    key    = "dynamic_rds/terraform.tfstate"
    region = "eu-west-1"
  }
}