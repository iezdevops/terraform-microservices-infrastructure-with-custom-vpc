terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  cloud {
    organization = "Wearslot"

    workspaces {
      name = "infrastructure"
    }
  }
}

provider "aws" {

  alias      = "wearslot_infrastruture"
  region     = var.aws_region
  access_key = "AKIARWHOR4WO7YWUFMOT"
  secret_key = "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"

}

module "ec2" {
  source         = "./ec2"
  security_group = module.vpc.security_group
  public_subnet  = module.vpc.public_subnet
  private_subnet = module.vpc.private_subnet
  # private_ips    = "${cidrhost(var.public_subnet, 12)},${cidrhost(var.public_subnet, 13)}"
}

module "vpc" {
  source = "./vpc"
}

module "ecs" {
  source             = "./ecs"
  eips               = module.vpc.eips
  vpc_id             = module.vpc.vpc_id
  public_subnet      = module.vpc.public_subnet
  private_subnet     = module.vpc.private_subnet
  security_group     = module.vpc.security_group
  wearslot_ecs_tasks = module.vpc.wearslot_ecs_tasks
}
