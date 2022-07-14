resource "aws_iam_role" "task_execution_role" {

  name = "${var.project_name}-ecs-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_policy" "task_execution_policy" {

  name = "${var.project_name}-ecs-task-execution-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecs:*",
          "ecr:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Sid    = "EnableResourceToReadTheSecret",
        Effect = "Allow",
        Action = "secretsmanager:GetSecretValue",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "task_execution_role_policy" {

  role   = aws_iam_role.task_execution_role.id
  policy = data.aws_iam_policy_document.ecs_service_policy.json
}

resource "aws_iam_role_policy_attachment" "task_execution_role_policy_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_policy.arn
}
