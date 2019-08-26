resource "aws_s3_bucket" "tfadmin" {
  bucket = "${var.prefix}"
  acl    = "private"

  tags = {
    Name        = "${var.prefix}"
    Environment = "${var.tag_environment}"
  }
}
