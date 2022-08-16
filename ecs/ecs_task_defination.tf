data "template_file" "api_container_defs" {

  template = "${file("containers/api.json")}"

  vars = {
    secret_arn = "${aws_secretsmanager_secret.main.arn}"
    repo_url = "${aws_ecr_repository.api_repo.repository_url}:latest"
    container_name = "${var.container_name}"
  }
}

resource "aws_ecs_task_definition" "api_task" {

  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = "${aws_iam_role.task_execution_role.arn}"
  execution_role_arn       = "${aws_iam_role.task_execution_role.arn}"

  container_definitions = "${data.template_file.api_container_defs.rendered}"
  memory                = 512 # Specifying the memory our container requires
  cpu                   = 256 # Specifying the CPU our container requires
}


# data "template_file" "storefront_container_defs" {

#   template = "${file("containers/storefront.json")}"

#   vars = {
#     secret_arn = "${aws_secretsmanager_secret.main.arn}"
#     repo_url = "${aws_ecr_repository.storefront_repo.repository_url}:latest"
#     container_name = "${var.container_name}"
#   }
# }


# resource "aws_ecs_task_definition" "storefront_task" {

#   family                   = "app"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   task_role_arn            = "${aws_iam_role.task_execution_role.arn}"
#   execution_role_arn       = "${aws_iam_role.task_execution_role.arn}"

#   container_definitions = "${data.template_file.storefront_container_defs.rendered}"
#   memory                = 512 # Specifying the memory our container requires
#   cpu                   = 256 # Specifying the CPU our container requires
# }


data "template_file" "store_manager_container_defs" {

  template = "${file("containers/storemanager.json")}"

  vars = {
    secret_arn = "${aws_secretsmanager_secret.main.arn}"
    repo_url = "${aws_ecr_repository.store_manager_repo.repository_url}:latest"
    container_name = "${var.container_name}"
  }
}

resource "aws_ecs_task_definition" "store_manager_task" {

  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = "${aws_iam_role.task_execution_role.arn}"
  execution_role_arn       = "${aws_iam_role.task_execution_role.arn}"

  container_definitions = "${data.template_file.store_manager_container_defs.rendered}"
  memory                = 512 # Specifying the memory our container requires
  cpu                   = 256 # Specifying the CPU our container requires
}