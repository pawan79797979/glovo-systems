# cloudfront

resource "aws_cloudfront_distribution" "elb_distribution" {
  origin {
    domain_name = "${local.ELB_DNS}"
    origin_id = "lde_vm"
	
	custom_origin_config {
    http_port = 8080
    https_port = 443
    origin_protocol_policy = "http-only"
    origin_ssl_protocols = [
        "SSLv3",
        "TLSv1"]
    }
    custom_header = {
      name = "${var.CUSTOM_HEADER_NAME}"
      value = "${var.CUSTOM_HEADER_VALUE}"
    }

     }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

 
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "lde_vm"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0  
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "JP"]
    }
  }

    tags {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
