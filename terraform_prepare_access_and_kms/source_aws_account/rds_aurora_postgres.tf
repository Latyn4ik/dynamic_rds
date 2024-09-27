locals {
  aurora_name = "source-aurora-postgres-test"
}

module "aurora_instance" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.9.1"

  name            = local.aurora_name
  engine          = "aurora-postgresql"
  engine_version  = "15.4"
  master_username = "postgres"
  instance_class  = "db.r6g.large"
  # instances = {
  #   one = {}
  # }


  ### Networking ###
  vpc_id                 = var.vpc_id
  create_db_subnet_group = true
  db_subnet_group_name   = "${local.aurora_name}-db-subnet-group"
  # security_group_rules = {
  #   ex1_ingress = {
  #     cidr_blocks = ["10.20.0.0/20"]
  #   }
  #   ex1_ingress = {
  #     source_security_group_id = "sg-12345678"
  #   }
  # }

  ### Storage ###
  storage_encrypted = true

  ### Monitoring ###
  create_monitoring_role       = true
  monitoring_interval          = 60
  performance_insights_enabled = false


  allow_major_version_upgrade = true
  apply_immediately           = true

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {}
}