resource "aws_security_group" "sg_rds" {
  name        = "sg-rds-sentry"
  description = "Security group for RDS PostgreSQL"
  vpc_id    = module.my_vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "Allow PostgreSQL access from EKS"
    cidr_blocks = ["10.10.7.0/24","10.10.8.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-rds-sentry"
  }
}

resource "aws_security_group" "sg_redis" {
  name        = "sg-redis-sentry"
  description = "Security group for ElastiCache Redis"
  vpc_id    = module.my_vpc.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    description = "Allow Redis access from EKS"
    cidr_blocks = ["10.10.7.0/24","10.10.8.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-redis-sentry"
  }
}
