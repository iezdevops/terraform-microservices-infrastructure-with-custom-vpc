resource "aws_iam_role" "wearslot" {
  
  name = "wearslot-ecs-iam-role"
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


resource "aws_iam_role_policy" "wearslot" {
  
  role   = "${aws_iam_role.wearslot.id}"
  policy = "${data.aws_iam_policy_document.ecs_service_policy.json}"
}

# resource "aws_iam_role_policy_attachment" "wearslot" {
#     role       = "${aws_iam_role.wearslot.name}"
#     policy_arn = "${aws_iam_role_policy.wearslot.arn}"
# }