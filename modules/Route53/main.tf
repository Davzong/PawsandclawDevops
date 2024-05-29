// Route traffice to the ALB

data "aws_route53_zone" "host_web_address" {
  name = var.host_web_address
}



resource "aws_route53_record" "prod_A" {
  zone_id = data.aws_route53_zone.host_web_address.zone_id
  name    = var.host_web_address
  type    = "A"

  alias {
    name                   = var.alb_info.dns_name
    zone_id                = var.alb_info.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "prod_AAAA" {
  zone_id = data.aws_route53_zone.host_web_address.zone_id
  name    = var.host_web_address
  type    = "AAAA"

  alias {
    name                   = var.alb_info.dns_name
    zone_id                = var.alb_info.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "prod_www_A" {
  zone_id = data.aws_route53_zone.host_web_address.zone_id
  name    = "www.${var.host_web_address}"
  type    = "A"

  alias {
    name                   = var.alb_info.dns_name
    zone_id                = var.alb_info.zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "uat_A" {
  zone_id = data.aws_route53_zone.host_web_address.zone_id
  name    = "uat.${var.host_web_address}"
  type    = "A"

  alias {
    name                   = var.alb_info.dns_name
    zone_id                = var.alb_info.zone_id
    evaluate_target_health = true
  }
}

