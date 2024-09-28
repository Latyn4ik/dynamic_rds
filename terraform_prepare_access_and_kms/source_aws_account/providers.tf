provider "aws" {
  region = var.source_aws_region
  alias  = "source"
  default_tags {
    tags = {
      Terraform = true
    }
  }
}

provider "aws" {
  region = var.target_aws_region
  alias  = "target"
  default_tags {
    tags = {
      Terraform = true
    }
  }
}