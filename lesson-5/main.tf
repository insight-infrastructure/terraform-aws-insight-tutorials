provider "aws" {
  region = "us-east-2"
}

variable "public_key_path" {
  type = string
}

data "aws_region" "current" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "v2.37.0"

  name = "lesson-5"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_region.current.name}a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]
}

module "hello" {
  source = "./modules/hello-world-instance-2"

  create = false

  public_key_path = var.public_key_path
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
}


module "foo" {
  source = "./modules/hello-world-instance-2"

  instance_count = 1
//  create = false

  instance_text = "bar"
  public_key_path = var.public_key_path
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
}

module "stuff" {
  source = "./modules/hello-world-instance-2"

  instance_count = 3

  public_key_path = var.public_key_path
  instance_text = "Stuff and things"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
}

output "hello_eip" {
  value = module.hello.eips
}

output "foo_eip" {
  value = module.foo.eips
}

output "stuff_eip" {
  value = module.stuff.eips
}

output "hello_public_ips" {
  value = module.hello.public_ips
}

output "foo_public_ips" {
  value = module.foo.public_ips
}

output "stuff_public_ips" {
  value = module.stuff.public_ips
}