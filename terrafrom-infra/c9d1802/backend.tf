terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "dynamic_rds/c9d1802/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "mock"
  }
}
