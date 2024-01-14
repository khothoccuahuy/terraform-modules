resource "aws_route53_zone" "private" {
  name = "${var.route53_zone_domain_name}."

  vpc {
    vpc_id = var.vpc_id
  }

  tags = merge(
  {
    Environment = var.environment
    Terraform   = "true"
  },
  var.tags
  )

  lifecycle {
    ignore_changes = [
      vpc
    ]
  }

}