output "s3_arn" {
  value       = aws_s3_bucket.s3_bucket.arn
  description = "The ARN of the S3 bucket"
}
