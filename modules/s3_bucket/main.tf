# create S3 bucket and enabel the versioning 

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name  # Change this to a unique bucket name
  acl    = "private"  # Set the ACL as needed (e.g., private, public-read)

  versioning {
    enabled = true
  }

  tags = {
    Name        = var.s3_bucket_name
    
  }
}


resource "aws_s3_bucket_public_access_block" "access_type" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls          = true
  ignore_public_acls          = true
  restrict_public_buckets     = true
  block_public_policy         = true
}

