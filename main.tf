terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    profile        = "wearslot"
    bucket         = "wearslot-tfbucket"
    key            = "global/tf-infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locking"
  }

  # cloud {
  #   organization = "Wearslot"

  #   workspaces {
  #     name = "infrastructure"
  #   }
  # }
}

provider "aws" {
  region  = var.region
  profile = "default"
}

resource "aws_s3_bucket" "infra_backend_storage" {
  bucket = "${var.project_name}-tfbucket"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

resource "aws_dynamodb_table" "name" {
  name         = "terraform-state-locking"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
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
