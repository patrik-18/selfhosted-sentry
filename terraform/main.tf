provider "aws" {
  region = "eu-central-1"
}

module "my_vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = "10.10.0.0/16"
  vpc_name       = "selfhosted-sentry-vpc"
  vpc_tags       = {
    Environment = "test"
  }
}

module "eks" {
  source         = "./modules/eks"
  cluster_name   = "selfhosted-sentry-eks"
  k8s_version    = "1.31"
  subnet_ids     = [module.subnets.private_eks_subnet_1a_id, module.subnets.private_eks_subnet_1b_id]
  node_count     = 2
  node_min       = 1
  node_max       = 3
  instance_types = ["t3.medium"]
  iam_users      = [
    "arn:aws:iam::688567297177:user/cicd-automation"
  ]
}

module "rds" {
  source         = "./modules/rds"
  db_username   = local.secret_data.username
  db_password   = local.secret_data.password
  db_subnet_group = "sentry-db-subnet"
  security_group = aws_security_group.sg_rds.id
  subnet_ids    = [module.subnets.private_db_subnet_1a_id, module.subnets.private_db_subnet_1b_id]
}

module "elasticache" {
  source         = "./modules/elasticache"
  security_group = aws_security_group.sg_redis.id
  subnet_ids    = [module.subnets.private_db_subnet_1a_id, module.subnets.private_db_subnet_1b_id]
}
