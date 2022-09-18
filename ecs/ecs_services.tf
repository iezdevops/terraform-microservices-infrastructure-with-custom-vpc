resource "aws_ecs_service" "ecs" {

  name = "${var.project_name}-ecs"

  task_definition = aws_ecs_task_definition.app_task.arn
  cluster         = aws_ecs_cluster.cluster.id
  desired_count   = 1

  depends_on = [
    aws_alb_listener.lb_listener, 
    aws_iam_role_policy.task_execution_role_policy,
    aws_iam_role.task_execution_role
  ]

  launch_type = "FARGATE"
  force_new_deployment = true

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    security_groups  = ["${aws_security_group.ecs_sg.id}"]
    subnets          = [for subnet in var.subnets : subnet]
    assign_public_ip = true
  }

}
