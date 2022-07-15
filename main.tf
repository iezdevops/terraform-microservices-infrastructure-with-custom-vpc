terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  # backend "s3" {

  # }

  # cloud {
  #   organization = "Wearslot"

  #   workspaces {
  #     name = "infrastructure"
  #   }
  # }
}

provider "aws" {
  region     = var.region
  access_key = "AKIARWHOR4WO7YWUFMOT"
  secret_key = "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"
}

resource "aws_s3_bucket" "infra_backend_storage" {
  bucket = "${var.project_name}-tfstate"
}

module "vpc" {
  source       = "./vpc"
  project_name = var.project_name
  az_count     = 2
  app_port     = var.container_port
}

module "ec2" {
  source         = "./ec2"
  security_group = module.vpc.security_group
  public_subnet  = module.vpc.public_subnet
  private_subnet = module.vpc.private_subnet
  project_name   = var.project_name
}

module "ecs" {
  source         = "./ecs"
  eips           = module.vpc.eips
  vpc_id         = module.vpc.vpc_id
  public_subnet  = module.vpc.public_subnet
  private_subnet = module.vpc.private_subnet
  security_group = module.vpc.security_group
  ecs_sg         = module.vpc.ecs_sg
  project_name   = var.project_name
  registry_name  = "${var.project_name}/registry"
  app_count      = var.ecs_app_count
  container_name = var.container_name
  container_port = var.container_port
}

module "rds" {
  source         = "./rds"
  security_group = module.vpc.security_group
  project_name   = var.project_name
  vpc_id         = module.vpc.vpc_id
}
