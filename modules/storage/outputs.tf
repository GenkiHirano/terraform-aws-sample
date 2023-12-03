output "private_bucket" {
  value = aws_s3_bucket.private.id
}

output "public_bucket" {
  value = aws_s3_bucket.public.id
}

output "alb_log_bucket" {
  value = aws_s3_bucket.alb_log.id
}
