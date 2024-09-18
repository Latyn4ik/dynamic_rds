terraform {
  backend "s3" {
    bucket = "test-oidc-access-prepare-tfstate"
    key    = "oidc/terraform.tfstate"
    region = "eu-central-1"
  }
}