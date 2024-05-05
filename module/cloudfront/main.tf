# provider "aws" {
#   region = "ap-southeast-2"  // CloudFront requires some resources like S3 origins to be in us-east-1
# }

# # S3 bucket to store website content
# resource "aws_s3_bucket" "bucket" {
#   bucket = "my-unique-bucket-name-12345"
#   acl    = "public-read"

#   website {
#     index_document = "index.html"
#     error_document = "error.html"
#   }

#   policy = <<POLICY
#     {
#     "Version":"2012-10-17",
#     "Statement":[
#         {
#         "Sid":"PublicReadGetObject",
#         "Effect":"Allow",
#         "Principal": "*",
#         "Action":["s3:GetObject"],
#         "Resource":["arn:aws:s3:::my-unique-bucket-name-12345/*"]
#         }
#     ]
#     }
#     POLICY
# }

# # CloudFront distribution that uses the S3 bucket as an origin
# resource "aws_cloudfront_distribution" "s3_distribution" {
#   origin {
#     domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
#     origin_id   = "S3-Origin"

#     custom_origin_config {
#       http_port                = 80
#       https_port               = 443
#       origin_protocol_policy   = "http-only"
#       origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
#     }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   default_root_object = "index.html"

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "S3-Origin"

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "redirect-to-https"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   price_class = "PriceClass_100"

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }

#   tags = {
#     Environment = "UAT"
#   }
# }
