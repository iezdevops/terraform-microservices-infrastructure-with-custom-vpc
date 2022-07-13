resource "aws_vpc" "vpc" {

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  lifecycle {
    create_before_destroy = true
  }
}
