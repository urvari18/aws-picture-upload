output "api_endpoint" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}

output "bucket_name" {
  value = aws_s3_bucket.image_bucket.bucket
}
