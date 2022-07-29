resource "aws_secretsmanager_secret" "main" {

  name = "${var.project_name}-secrets-manager"
}

variable "secrets" {
  default = {
    APP_NAME  = "Wearslot"
    APP_ENV   = "local"
    APP_ID    = ""
    APP_DEBUG = "true"
    APP_URL   = "http://wearslot.com"

    LOG_CHANNEL = "stack"
    LOG_LEVEL   = "debug"

    DB_CONNECTION = "mysql"
    DB_HOST       = ""
    DB_PORT       = "3306"
    DB_DATABASE   = "wearslot_db"
    DB_USERNAME   = ""
    DB_PASSWORD   = ""

    MAIL_MAILER       = "smtp"
    MAIL_HOST         = "mail.wearslot.com"
    MAIL_PORT         = "587"
    MAIL_USERNAME     = "email@wearslot.com"
    MAIL_PASSWORD     = "email@spaces"
    MAIL_ENCRYPTION   = "tls"
    MAIL_FROM_ADDRESS = "info@wearslot.com"
    MAIL_FROM_NAME    = "Wearslot"

    AWS_ACCESS_KEY_ID           = ""
    AWS_SECRET_ACCESS_KEY       = ""
    AWS_DEFAULT_REGION          = "us-east-1"
    AWS_BUCKET                  = "wearslot-storage"
    AWS_USE_PATH_STYLE_ENDPOINT = "false"
    AWS_ENDPOINT                = "http://s3.us-east-1.amazonaws.com"
    AWS_URL                     = "wearslot-storage.s3.us-east-1.amazonaws.com"
    AWS_VERIFY                  = "false"
    AWS_OPTION_SCHEME           = "http"

    PUSHER_APP_ID      = ""
    PUSHER_APP_KEY     = ""
    PUSHER_APP_SECRET  = ""
    PUSHER_APP_CLUSTER = "mt1"

    MIX_PUSHER_APP_KEY     = ""
    MIX_PUSHER_APP_CLUSTER = ""

    DOMAIN_NAME = "http://wearslot.com"
  }

  type = map(string)
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(var.secrets)
}
