variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "target_aws_account_id" {
  description = "AWS Account ID of the target account that will be allowed to use the KMS key"
  type        = string
  default     = "962547359624"
}