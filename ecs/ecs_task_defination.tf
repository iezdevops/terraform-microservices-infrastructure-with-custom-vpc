resource "aws_ecs_task_definition" "app_task" {

  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = "${aws_iam_role.iam_role.arn}"
  execution_role_arn       = "${aws_iam_role.iam_role.arn}"

  # container_definitions = file("containers/definations.json")
  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.container_name}",
      "image": "${aws_ecr_repository.ecr_repo.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  memory                = 512 # Specifying the memory our container requires
  cpu                   = 256 # Specifying the CPU our container requires
}
