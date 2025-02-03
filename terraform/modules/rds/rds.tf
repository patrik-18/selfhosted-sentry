resource "aws_db_instance" "sentry_db" {
  identifier             = "sentry-postgres"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                = "postgres"
  engine_version        = "16.4"
  instance_class        = "db.t3.medium"
  username              = var.db_username
  password              = var.db_password
  publicly_accessible   = false
  db_subnet_group_name  = var.db_subnet_group
  vpc_security_group_ids = [var.security_group]
  multi_az              = true
  backup_retention_period = 7
  skip_final_snapshot    = true
  apply_immediately      = true
  parameter_group_name  = "default.postgres15"
}

resource "aws_db_subnet_group" "sentry_db_subnet" {
  name       = "sentry-db-subnet"
  subnet_ids = var.subnet_ids
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.sentry_db.endpoint
}
