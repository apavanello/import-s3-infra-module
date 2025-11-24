import {
  for_each = local.buckets
  to       = module.s3_local[each.key].aws_s3_bucket.this
  id       = each.key
}
