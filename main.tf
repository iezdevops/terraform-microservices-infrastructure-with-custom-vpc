terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  # User s3 bucket as the terraform state backend 
  # backend "s3" {
  #   profile        = "default"       # The default aws configuration profile (optional)
  #   bucket         = "[bucket-name]" # This would be the name of the s3 bucket for terraform state file
  #   key            = "global/tf-infra/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-locking" # This requires the name of the dynamo db created for locking terraform state file.
  # }
}

provider "aws" {
  region  = var.region
  profile = "default"
}

# resource "aws_s3_bucket" "tfstate_backend_storage" {
#   bucket = "${var.project_name}-tfstate-bucket"

#   lifecycle {
#     prevent_destroy = true
#   }

#   versioning {
#     enabled = true
#   }

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
#   }

# }

# resource "aws_dynamodb_table" "name" {
#   name         = "terraform-state-locking"
#   hash_key     = "LockID"
#   billing_mode = "PAY_PER_REQUEST"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }


# module "vpc" {
#   source       = "./vpc"
#   project_name = var.project_name
#   az_count     = 2
#   app_port     = var.container_port
# }

# module "ec2" {
#   source         = "./ec2"
#   security_group = module.vpc.security_group
#   public_subnet  = module.vpc.public_subnet
#   private_subnet = module.vpc.private_subnet
#   project_name   = var.project_name
# }


data "aws_vpc" "default" {
  id      = "vpc-0576f451206bf9341"
  default = true
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_groups" "default" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


module "ecs" {
  source         = "./ecs"
  vpc_id         = data.aws_vpc.default.id
  subnets  = data.aws_subnet_ids.public_subnets.ids
  project_name   = var.project_name
  registry_name  = "${var.project_name}/registry"
  app_count      = var.ecs_app_count
  container_name = var.container_name
  container_port = var.container_port
}

# module "rds" {
#   source       = "./rds"
#   project_name = var.project_name
#   vpc_id       = module.vpc.vpc_id
# }
