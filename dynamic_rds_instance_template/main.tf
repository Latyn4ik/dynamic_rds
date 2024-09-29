module "aurora_instance" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.9.1"

  name           = var.name
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  instances      = var.instances

  snapshot_identifier = var.snapshot_identifier

  ### Credentials ###
  master_username             = var.master_username
  master_password             = var.master_password
  manage_master_user_password = var.manage_master_user_password

  ### Networking ###
  vpc_id                 = var.vpc_id
  create_db_subnet_group = var.create_db_subnet_group
  db_subnet_group_name   = "${var.name}-db-subnet-group"
  subnets                = var.subnets
  vpc_security_group_ids = var.vpc_security_group_ids

  ### Storage ###
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id

  ### Monitoring ###
  create_monitoring_role                = var.create_monitoring_role
  iam_role_name                         = "${var.name}-monitoring"
  monitoring_interval                   = var.monitoring_interval
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period


  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  skip_final_snapshot         = var.skip_final_snapshot

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = {}
}