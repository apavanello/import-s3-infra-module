locals {
  buckets = yamldecode(file("${path.module}/buckets.yaml"))
}

module "s3_local" {
  source = "./modules/s3-local"

  for_each = local.buckets

  bucket_name   = each.key
  bucket_policy = file("${path.module}/policies/${each.key}.json")
  folders       = toset(each.value.folders)
}
