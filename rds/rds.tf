resource "aws_db_instance" "app_db" {
  vpc_security_group_ids = ["${aws_security_group.rds_security_group.id}"]
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  db_name                = "${var.project_name}_db"
  skip_final_snapshot    = true
}
