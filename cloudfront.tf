locals{
    s3_bucket_name = "paws-and-claws-test02"
    domain = "happypawsandclaws.com"
    hosted_zone_id = "Z04548302VFWFA2JYR8VD"
    cert_arn = "arn:aws:acm:us-east-1:058264389558:certificate/cc7cd607-a249-4ec8-b51c-00f8363023d4"
}

# locals {
#   s3_origin_id   = "${var.s3_name}-origin"
#   domain = "${var.s3_name}.s3-website-${var.region}.amazonaws.com"
# }


# resource "aws_cloudfront_origin_access_control" "main" {
#   name = "s3-cloudfront-oac-test"
#   origin_access_control_origin_type = "s3"
#   signing_behavior = "always"
#   signing_protocol = "sigv4"

# }

resource "aws_cloudfront_distribution" "this" {
  
  enabled = true
  aliases = [local.domain]
  default_root_object = "index.html"
  is_ipv6_enabled = true
  wait_for_deployment = true
  
  origin {
    origin_id                = aws_s3_bucket.this.bucket
    domain_name              = local.domain
    # origin_access_control_id = aws_cloudfront_origin_access_control.main.id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }


  default_cache_behavior {
    
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods = ["HEAD", "GET", "OPTIONS"]
    cache_policy_id = "2e54312d-136d-493c-8eb9-b001f22f67d2"
    target_origin_id = local.s3_bucket_name

    # forwarded_values {
    #   query_string = true

    #   cookies {
    #     forward = "all"
    #   }
    # }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  viewer_certificate {
        acm_certificate_arn = local.cert_arn
        minimum_protocol_version = "TLSv1.2_2021"
        ssl_support_method = "sni-only"
  }

  price_class = "PriceClass_200"
  
}