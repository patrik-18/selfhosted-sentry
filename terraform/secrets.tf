# Development PostgreSQL Cluster
data "aws_secretsmanager_secret" "test_rds_secret" {
  name = "test/rds/passwd"
}

data "aws_secretsmanager_secret_version" "test_rds_secret_version_v2" {
  secret_id = data.aws_secretsmanager_secret.test_rds_secret.id
}

locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.test_rds_secret_version_v2.secret_string)
}