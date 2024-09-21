variable "target_aws_region" {
  description = "AWS Region where will be located final RDS snapshot. And KMS key will be deployed in this region."
  type    = string
  default = "eu-west-1"
}

variable "target_aws_account_id" {
  description = "AWS Account ID of the target account that will be allowed to use the KMS key"
  type        = string
  default     = "962547359624"
}