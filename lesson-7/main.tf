provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "insight-tf-demos-terraform-state"
    key    = "stuff/things/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "insight-tf-demos-terraform-state-lock"

  }
}

variable "public_key_path" {
  type = string
}

data "aws_region" "current" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "lesson-4"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_region.current.name}a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]
}

module "hello" {
  source = "./modules/hello-world-instance"
  public_key_path = var.public_key_path
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
}

module "stuff" {
  source = "./modules/hello-world-instance"
  public_key_path = var.public_key_path
  instance_text = "Stuff and things"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
}

output "stuff_ip" {
  value = module.stuff.public_ip
}

output "hello_ip" {
  value = module.hello.public_ip
}

module "vpc2" {
  source = "terraform-aws-modules/vpc/aws"
}