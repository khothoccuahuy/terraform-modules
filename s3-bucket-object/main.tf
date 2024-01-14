resource "aws_s3_bucket_object" "bucket_object" {
  bucket = var.name
  key = var.key
  source = var.object_source
  etag = var.etag
  content_type = var.content_type
  content_disposition = var.content_disposition
  tags = merge(
  {},
  var.tags
  )

  lifecycle {
    ignore_changes = all
  }
}