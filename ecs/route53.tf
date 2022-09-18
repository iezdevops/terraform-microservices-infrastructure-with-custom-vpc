resource "aws_route53_zone" "primary" {
  name = "shareyaspace.com"
}

resource "aws_route53_record" "primary" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "shareyaspace.com"
  type    = "A"

  alias {
    name                   = aws_alb.lb.dns_name
    zone_id                = aws_alb.lb.zone_id
    evaluate_target_health = true
  }
}

# This creates an SSL certificate
resource "aws_acm_certificate" "myapp" {
  domain_name       = aws_route53_record.primary.fqdn
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# This is a DNS record for the ACM certificate validation to prove we own the domain
#
# This example, we make an assumption that the certificate is for a single domain name so can just use the first value of the
# domain_validation_options.  It allows the terraform to apply without having to be targeted.
# This is somewhat less complex than the example at https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation
# - that above example, won't apply without targeting

resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_type
  zone_id         = aws_route53_zone.primary.id
  ttl             = 60
  #   provider = aws.account_route53
}

# This tells terraform to cause the route53 validation to happen
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.myapp.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
