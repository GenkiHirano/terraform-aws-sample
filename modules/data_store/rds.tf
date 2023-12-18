resource "aws_db_parameter_group" "this" {
  name   = var.name
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

resource "aws_db_option_group" "this" {
  name                 = var.name
  engine_name          = "mysql"
  major_engine_version = "8.0"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"
  }
}

resource "aws_db_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_private_ids
}

resource "aws_db_instance" "this" {
  identifier            = var.name
  engine                = "mysql"
  engine_version        = "8.0.34"
  instance_class        = "db.t3.small"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  storage_encrypted     = true
  kms_key_id            = var.kms_key_arn
  username              = "admin"
  // apply後にpasswordを変更
  // aws rds modifydbinstance dbinstanceidentifier 'example' \  masteruserpassword 'NewMasterPassword!'
  password                   = "VeryStrongPassword!"
  multi_az                   = true
  publicly_accessible        = false
  backup_window              = "09:10-09:40"
  backup_retention_period    = 30
  maintenance_window         = "mon:10:10-mon:10:40"
  auto_minor_version_upgrade = false
  // 削除保護： 検証段階ではfalseで設定
  // deletion_protection        = true
  deletion_protection = false
  // インスタンス削除時のスナップショット作成： 検証段階ではtrueで設定
  // skip_final_snapshot        = false
  skip_final_snapshot    = true
  port                   = 3306
  apply_immediately      = false
  vpc_security_group_ids = [var.rds_security_group_id]
  parameter_group_name   = aws_db_parameter_group.this.name
  option_group_name      = aws_db_option_group.this.name
  db_subnet_group_name   = aws_db_subnet_group.this.name

  lifecycle {
    ignore_changes = [password]
  }
}


