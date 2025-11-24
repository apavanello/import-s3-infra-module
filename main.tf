module "s3_local" {
  source = "./modules/s3-local"

  bucket_name   = var.bucket_name
  bucket_policy = file("${path.module}/policies/${var.bucket_name}.json")
  folders       = var.folders
}
