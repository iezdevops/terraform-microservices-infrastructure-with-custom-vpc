resource "aws_ecs_service" "ecs" {

  name = "${var.project_name}-ecs"

  task_definition = aws_ecs_task_definition.app_task.arn
  cluster         = aws_ecs_cluster.cluster.id
  desired_count   = 1

  # iam_role        = aws_iam_role.iam_role.arn
  depends_on      = [aws_alb_listener.lb_listener, aws_iam_role_policy.task_execution_role_policy]

  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }

  network_configuration {
    security_groups = ["${var.ecs_sg.id}"]
    subnets         = [for subnet in var.private_subnet : subnet.id]
  }

}
