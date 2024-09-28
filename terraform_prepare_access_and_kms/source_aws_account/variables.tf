variable "source_aws_region" {
  description = "The AWS region where the RDS Aurora cluster (encrypted AWS managed KMS key) will be deployed, from which the RDS snapshot will be made for the Dynamic RDS Aurora cluster in the target AWS account"
  type        = string
  default     = "eu-central-1"
}

variable "source_region_vpc_id" {
  description = "VPC ID in Source region for RDS Aurora cluster (encrypted AWS managed KMS key)"
  type        = string
  default     = "vpc-0b02e24130ce8e703"
}

variable "source_region_subnets" {
  description = "DB Subnets of VPC in Source region for RDS Aurora cluster (encrypted AWS managed KMS key)"
  type        = list(string)
  default     = ["subnet-02a78ce395384ac51", "subnet-02bae81ce65f6ae05", "subnet-05a069e62de57fa78"]
}


variable "target_aws_region" {
  description = "AWS Region where will be located final RDS snapshot. And KMS key will be deployed in this region."
  type        = string
  default     = "eu-west-1"
}

variable "target_aws_account_id" {
  description = "AWS Account ID of the target account that will be allowed to use the KMS key"
  type        = string
  default     = "962547359624"
}
