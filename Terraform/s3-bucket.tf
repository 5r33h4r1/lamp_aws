resource "aws_s3_bucket" "tfadmin" {
  bucket = "${var.backend_bucket}"
  acl    = "private"

  tags = {
    Name        = "tf-backend"
    Environment = "Dev"
  }
}
