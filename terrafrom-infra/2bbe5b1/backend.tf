terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "dynamic_rds/2bbe5b1/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "mock"
  }
}
