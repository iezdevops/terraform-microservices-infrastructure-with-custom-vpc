# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 2.7.0"
#     }
#   }
# }

provider "aws" {

  alias      = "wearslot_infrastruture"
  region     = var.aws_region
  access_key = "AKIARWHOR4WO7YWUFMOT"
  secret_key = "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"

}

module "ec2" {
  source = "./ec2"
  security_group = module.vpc.security_group
}

module "vpc" {
  source = "./vpc"
}

module "ecs" {
  source = "./ecs"
  security_group = module.vpc.security_group
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.subnets
}
