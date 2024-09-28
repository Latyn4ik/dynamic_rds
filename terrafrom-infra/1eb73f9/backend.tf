terraform {
  backend "s3" {
    bucket         = "test-oidc-access-prepare-tfstate-target-account"
    key            = "dynamic_rds/1eb73f9/terraform.tfstate"
    region         = "eu-west-1"
    # dynamodb_table = "mock"
  }
}
