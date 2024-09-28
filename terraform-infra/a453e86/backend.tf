terraform {
  backend "s3" {
    bucket         = "test-oidc-access-prepare-tfstate-target-account"
    key            = "dynamic_rds/a453e86/terraform.tfstate"
    region         = "eu-west-1"
    # dynamodb_table = "mock"
  }
}
