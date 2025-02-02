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
