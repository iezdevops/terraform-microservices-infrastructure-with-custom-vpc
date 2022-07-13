resource "aws_secretsmanager_secret" "main" {

  name = "${var.project_name}-secrets-manager"
}
