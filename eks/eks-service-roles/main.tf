
###############################################################
#       Module manages IAM roles for k8s service accounts     #
###############################################################

locals {

}

#STS Access for service account
data "aws_iam_policy_document" "aws_iam_policy_document_sts" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.aws_iam_openid_connect_provider_url, "https://", "")}:sub"
      //      variable = replace(var.aws_iam_openid_connect_provider_url, "https://", "")
      values = ["system:serviceaccount:${var.eks_namespace}:${var.eks_service_account_name}"]
    }

    principals {
      identifiers = [var.aws_iam_openid_connect_provider_arn]
      type        = "Federated"
    }
  }
}

# Grant Route53 R\W for external DNS service account
resource "aws_iam_role" "aws_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.aws_iam_policy_document_sts.json
  name               = var.eks_service_role_name
}

resource "aws_iam_policy" "aws_iam_policy" {
  name   = "${var.eks_service_role_name}-iam-policy"
  policy = var.iam_role_policy_document_json
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  policy_arn = aws_iam_policy.aws_iam_policy.arn
  role       = aws_iam_role.aws_iam_role.name
}
