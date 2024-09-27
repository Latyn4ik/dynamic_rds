terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "dynamic_rds/d21809c/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "mock"
  }
}
