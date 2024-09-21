provider "aws" {
  region = var.target_aws_region
  default_tags {
    tags = {
      Terraform = true
    }
  }
}