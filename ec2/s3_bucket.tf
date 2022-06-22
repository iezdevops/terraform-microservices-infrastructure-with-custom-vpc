
resource "aws_s3_bucket" "s3_app_storage" { 

    bucket = "${var.app_owner}-bucket"
}