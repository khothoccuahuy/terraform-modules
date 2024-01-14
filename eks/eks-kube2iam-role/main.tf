
###############################################################
#       Module manages IAM roles for k8s service accounts     #
###############################################################

data "aws_iam_policy_document" "assume" {
  version = "2012-10-17"

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"
      identifiers = [
        var.node_iam_role_arn
      ]
    }
  }
}

# Grant Route53 R\W for external DNS service account
resource "aws_iam_role" "aws_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.assume.json
  name               = var.role_name
}

resource "aws_iam_policy" "aws_iam_policy" {
  name   = "${var.role_name}-iam-policy"
  policy = var.iam_role_policy_document_json
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  policy_arn = aws_iam_policy.aws_iam_policy.arn
  role       = aws_iam_role.aws_iam_role.name
}
