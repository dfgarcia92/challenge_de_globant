module "s3_bucket_raw" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.0"

  bucket        = local.bucket_names.raw
  acl           = null
  force_destroy = var.s3_force_destroy

  versioning = {
    enabled = false
  }

  attach_policy = false
  policy        = null

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets

  tags = var.tags
}

################## intermediate data bucket ##################

module "s3_bucket_intermediate" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.0"

  bucket        = local.bucket_names.intermediate
  acl           = null
  force_destroy = var.s3_force_destroy

  versioning = {
    enabled = false
  }
  
  attach_policy = false
  policy        = null

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets

  tags = var.tags
}