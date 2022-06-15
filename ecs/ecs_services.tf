resource "aws_ecs_service" "wearslot_ecs" {

  name = "Wearslot-ecs"

  task_definition = aws_ecs_task_definition.wearslotapi.arn
  cluster         = aws_ecs_cluster.wearslot.id
  desired_count   = 1

  # iam_role        = aws_iam_role.foo.arn
  # depends_on      = [aws_iam_role_policy.foo]

  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = aws_alb_target_group.wearslot.arn
    container_name   = "wearslotapiservice"
    container_port   = 8000
  }

}
