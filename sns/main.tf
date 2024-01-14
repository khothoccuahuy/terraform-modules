resource "aws_sns_topic" "this" {
  name = var.name

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Name        = var.name
    Owner       = "Trustonic"
    Terraform   = "true"
  }, var.tags)
}

resource "aws_sns_topic_policy" "this" {
  count = var.create_topic_policy ? 1 : 0

  arn    = aws_sns_topic.this.arn
  policy = var.topic_policy
}
