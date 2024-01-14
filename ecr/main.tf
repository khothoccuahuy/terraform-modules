resource "aws_ecr_repository" "ecr_repository" {
  name                 = var.ecr_name
  image_tag_mutability = var.ecr_image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }

//tags = var.tags
  tags = merge(
  {},
  var.tags
  )

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  repository = aws_ecr_repository.ecr_repository.name

  policy = <<EOF
  {
      "rules": [
          {
              "rulePriority": 1,
              "description": "${var.ecr_lifecycle_policy_description}",
              "selection": {
                  "tagStatus": "untagged",
                  "countType": "imageCountMoreThan",
                  "countNumber": ${var.ecr_lifecycle_policy_count_number}
              },
              "action": {
                  "type": "expire"
              }
          },
          {
              "rulePriority": 2,
              "description": "Delete old docker image > 30 revisions",
              "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 30
              },
              "action": {
                "type": "expire"
              }
          }
      ]
  }
  EOF
}
