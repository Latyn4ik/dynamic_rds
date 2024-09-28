locals {
  aurora_name = "source-aurora-postgres-test"
}

module "aurora_instance" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.9.1"

  name           = local.aurora_name
  engine         = "aurora-postgresql"
  engine_version = "15.4"
  instance_class = "db.r6g.large"
  instances = {
    one = {}
  }


  ### Credentials ###
  master_username             = "postgres"
  master_password             = null
  manage_master_user_password = true

  ### Networking ###
  vpc_id                 = var.source_region_vpc_id
  create_db_subnet_group = true
  db_subnet_group_name   = "${local.aurora_name}-db-subnet-group"
  subnets                = var.source_region_subnets
  vpc_security_group_ids = [""]

  ### Storage ###
  storage_encrypted = true

  ### Monitoring ###
  create_monitoring_role       = true
  iam_role_name                = "${local.aurora_name}-monitoring"
  monitoring_interval          = 60
  performance_insights_enabled = false


  allow_major_version_upgrade = true
  apply_immediately           = true
  skip_final_snapshot         = true

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {}

  providers = {
    aws = aws.source
  }
}