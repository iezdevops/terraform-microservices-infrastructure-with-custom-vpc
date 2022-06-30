
resource "aws_s3_bucket" "s3_app_storage" {

  bucket = "${var.project_name}-bucket"
}

resource "aws_s3_bucket_acl" "s3_app_acl" {
  bucket = aws_s3_bucket.s3_app_storage.id
  acl    = "private"
}
