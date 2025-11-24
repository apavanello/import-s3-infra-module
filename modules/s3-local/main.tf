resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy
}

resource "aws_s3_object" "folders" {
  for_each = var.folders

  bucket = aws_s3_bucket.this.id
  key    = "${each.value}/"
  source = "/dev/null"
}
