resource "aws_route53_zone" "route53_zone" {
  name              = "${var.route53_zone_domain_name}."
  delegation_set_id = aws_route53_delegation_set.route53_delegation_set.id

  tags = merge(
    {
      Environment = var.environment
      Terraform   = "true"
    },
    var.tags
  )

  lifecycle {     # TEMP durint migration
    ignore_changes = [
      tags
    ]
  }

}

resource "aws_route53_delegation_set" "route53_delegation_set" {
  reference_name = var.route53_zone_reference_name
}

