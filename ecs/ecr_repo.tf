# data "aws_ecr_image" "api_image" {
#   repository_name = var.registry_name
#   image_tag       = "latest"
# }

resource "aws_ecr_repository" "wearslot_ecr_repo" {

  name = "wearslot"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

}

