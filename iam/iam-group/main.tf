resource "aws_iam_group" "iam_user_group" {
  name = var.iam_group_name
}

resource "aws_iam_group_membership" "iam_user_group_membership" {
  name  = "${var.iam_group_name}-membership"
  users = var.iam_group_user_list

  group = aws_iam_group.iam_user_group.name
}
