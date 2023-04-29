resource "aws_s3_bucket" "tf-state" {
  bucket        = "my-tf-state777"
}

resource "aws_s3_bucket_ownership_controls" "tf-ownership_controls" {
  bucket = aws_s3_bucket.tf-state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tf-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.tf-ownership_controls]
  
  bucket = aws_s3_bucket.tf-state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.tf-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf-default" {
  bucket = aws_s3_bucket.tf-state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.tf-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_kms_key" "tf-bucket-key" {
 description             = "This key is used to encrypt bucket objects"
 deletion_window_in_days = 10
 enable_key_rotation     = true
}

resource "aws_kms_alias" "tf-key-alias" {
 name          = "alias/terraform-bucket-key"
 target_key_id = aws_kms_key.tf-bucket-key.key_id
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}