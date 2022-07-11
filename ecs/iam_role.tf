resource "aws_iam_role" "iam_role" {
  
  name = "${var.project_name}-ecs-role"
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


resource "aws_iam_policy" "iam_policy" {

  name = "${var.project_name}-ecr-access-policy"
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
    ]
  })
}

resource "aws_iam_role_policy" "iam_rpolicy" {
  
  role   = "${aws_iam_role.iam_role.id}"
  policy = "${data.aws_iam_policy_document.ecs_service_policy.json}"
}

resource "aws_iam_role_policy_attachment" "iam_rp_attachment" {
    role       = "${aws_iam_role.iam_role.name}"
    policy_arn = "${aws_iam_policy.iam_policy.arn}"
}