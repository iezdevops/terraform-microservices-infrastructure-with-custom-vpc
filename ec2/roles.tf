resource "aws_iam_role" "instance_role" {
  name = "${var.project_name}-instance-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "instance_rpolicy" {
  
  role   = "${aws_iam_role.instance_role.id}"
  policy = jsonencode({
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect = "Allow"
      }
    ]
  })
}