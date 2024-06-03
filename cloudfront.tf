locals{
    s3_bucket_name = "paws-and-claws-test02"
    domain = "happypawsandclaws.com"
    hosted_zone_id = "Z04548302VFWFA2JYR8VD"
    cert_arn = "arn:aws:acm:us-east-1:058264389558:certificate/cc7cd607-a249-4ec8-b51c-00f8363023d4"
}


resource "aws_cloudfront_distribution" "this" {
  
  enabled = true
  aliases = [local.domain]
  default_root_object = "index.html"
  is_ipv6_enabled = true
  wait_for_deployment = true
  
  origin {
    origin_id                = aws_s3_bucket.this.bucket
    origin_path              = "/out" 
    domain_name              = "${aws_s3_bucket.this.bucket_regional_domain_name}"


    #  s3_origin_config {
    #   origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path

    # }
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }


  default_cache_behavior {
    
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods = ["HEAD", "GET", "OPTIONS"]
    cache_policy_id = "2e54312d-136d-493c-8eb9-b001f22f67d2"
    target_origin_id = local.s3_bucket_name


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

resource "aws_route53_record" "a_record" {
  name    = local.domain
  type    = "A"
  zone_id = local.hosted_zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
  }
}

resource "aws_route53_record" "aaaa_record" {
  name    = local.domain
  type    = "AAAA"
  zone_id = local.hosted_zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
  }
}