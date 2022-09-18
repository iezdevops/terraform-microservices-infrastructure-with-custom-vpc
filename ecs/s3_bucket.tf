
resource "aws_s3_bucket" "app_storage" {
	bucket = "${var.project_name}-storage"
	force_destroy = true
}

resource "aws_s3_bucket_acl" "s3_app_acl" {
	bucket = aws_s3_bucket.app_storage.bucket
	acl    = "private"
}