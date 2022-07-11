resource "aws_secretsmanager_secret" "main" {

    name = "${var.project_name}-secrets-manager"
}

resource "aws_secretsmanager_secret_policy" "smc_policy" {

    secret_arn = aws_secretsmanager_secret.main.arn

    policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Sid": "EnableResourceToReadTheSecret",
            "Effect": "Allow",
            "Action": "secretsmanager:GetSecretValue",
            "Resource": "*"
            }
        ]
    }
    POLICY
}
