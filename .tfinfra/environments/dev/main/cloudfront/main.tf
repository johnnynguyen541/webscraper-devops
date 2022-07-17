# MODULES/FEATURES USED IN FEATURE

# RESOURCE
resource "aws_route53_zone" "hosted_zone" {
  name = var.cloudfront_domain_name
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.cloudfront_domain_name
  subject_alternative_names = ["*.${var.cloudfront_domain_name}"]
  validation_method         = "DNS"
  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-cloudfront-cert"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = "cert"
    Role        = "cloudfront"
  }
}

# validate cert:
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for d in aws_acm_certificate.cert.domain_validation_options : d.domain_name => {
      name   = d.resource_record_name
      record = d.resource_record_value
      type   = d.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.hosted_zone.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}

# creating A record for domain:
resource "aws_route53_record" "website_url" {
  name    = var.cloudfront_domain_name
  zone_id = aws_route53_zone.hosted_zone.zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf_dist.domain_name
    zone_id                = aws_cloudfront_distribution.cf_dist.hosted_zone_id
    evaluate_target_health = true
  }
}

#creating Cloudfront distribution :
resource "aws_cloudfront_distribution" "cf_dist" {
  # REQUIRED
  enabled             = true

  aliases             = [var.cloudfront_domain_name]

  # REQUIRED
  origin {
    domain_name = data.terraform_remote_state.scrape_cluster.outputs.alb_dns
    origin_id   = data.terraform_remote_state.scrape_cluster.outputs.alb_dns

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # REQUIRED
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = data.terraform_remote_state.scrape_cluster.outputs.alb_dns
    viewer_protocol_policy = "allow-all"

    forwarded_values {
      headers      = []
      query_string = true

      cookies {
        forward = "all"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "US", "CA"]
    }
  }

  tags = {
    Name        = "${var.env_tag}-${var.subenv_tag}-${var.project_tag}-cloudfront-cdn"
    Account     = var.account_tag
    Commit      = var.commit_tag
    Environment = "${var.env_tag}-${var.subenv_tag}"
    Project     = var.project_tag
    Resource    = "cdn"
    Role        = "cloudfront"
  }

  # REQUIRED
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}

/*
# SERVICE MODULE
module "NAME_OF_SERVICE" {
  source          = "../../../../services/SERVICE_TYPE/MODULE_NAME"

  # REQUIRED VARIABLES
  module_variable = var.local_variable_declared

  # OPTIONAL VARIABLES
  module_variable = var.local_variable_declared

  # OTHER VARIABLES
  module_variable = var.local_variable_declared

  # TAGS
  account_tag     = var.account_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tag        = var.ROLE_TAG_VAR
  subenv_tag      = var.subenv_tag
}

# MODULE
module "NAME_OF_MODULE" {
  source          = "../../../../modules/MODULE_NAME"

  # REQUIRED VARIABLES
  module_variable = var.local_variable_declared

  # OPTIONAL VARIABLES
  module_variable = var.local_variable_declared

  # OTHER VARIABLES
  module_variable = var.local_variable_declared

  # TAGS
  account_tag     = var.account_tag
  env_tag         = var.env_tag
  project_tag     = var.project_tag
  role_tag        = var.ROLE_TAG_VAR
  subenv_tag      = var.subenv_tag
}
*/