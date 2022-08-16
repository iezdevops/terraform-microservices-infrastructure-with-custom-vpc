resource "random_string" "db_username" {
  length           = 10
  special          = false
}

resource "random_string" "db_password" {
  length           = 16
  special          = false
}

resource "aws_db_instance" "app_db" {
  vpc_security_group_ids = ["${aws_security_group.rds_security_group.id}"]
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  db_name                = "${var.project_name}_db"
  username               = random_string.db_username.result
  password               = random_string.db_password.result
  skip_final_snapshot    = true
}

# resource "local_sensitive_file" "db_credentials" {
#   content         = "Username=${aws_db_instance.app_db.username}\nPassword=${aws_db_instance.app_db.password}"
#   filename        = "${var.project_name}.txt"
#   file_permission = "0400"
# }