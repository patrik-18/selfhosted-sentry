terraform {
  backend "s3" {
    bucket  = "tfm-state-688567297177"
    region  = "eu-central-1"
    encrypt = "true"
    dynamodb_table = "github-state-lock"
  }
}