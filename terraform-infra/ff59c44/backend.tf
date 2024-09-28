terraform {
  backend "s3" {
    bucket         = "test-oidc-access-prepare-tfstate-target-account"
    key            = "dynamic_rds/ff59c44/terraform.tfstate"
    region         = "eu-west-1"
    # dynamodb_table = "mock"
  }
}
