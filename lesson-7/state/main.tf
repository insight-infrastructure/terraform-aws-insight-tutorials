provider "aws" {
  region = "us-east-2"
}

module "terraform_state_backend" {
  source        = "git::https://github.com/cloudposse/terraform-aws-tfstate-backend.git?ref=master"
  namespace     = "insight-tf-demos" # This needs to be globally unique - change this
  region        = "us-east-1"
}

output "s3_bucket_id" {
  value = module.terraform_state_backend.s3_bucket_id
}

output "dynamodb_table_name" {
  value = module.terraform_state_backend.dynamodb_table_name
}
