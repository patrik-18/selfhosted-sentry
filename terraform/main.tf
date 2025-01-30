module "my_vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = "10.10.0.0/16"
  vpc_name       = "selfhosted-sentry-vpc"
  vpc_tags       = {
    Environment = "test"
  }
}