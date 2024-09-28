terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "dynamic_rds/03a6cb0/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "mock"
  }
}
