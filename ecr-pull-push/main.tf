
data "docker_registry_image" "pull_image" {
  name = var.pull_image
}

resource "null_resource" "pull_tag_push_image" {
  provisioner "local-exec" {
    command = <<EOT
    # Have to randomly sleep 0-10s to avoid docker flooding
    sleep $((RANDOM % 11)) && \
    docker login -u ${data.aws_ecr_authorization_token.docker_secret.user_name} -p ${data.aws_ecr_authorization_token.docker_secret.password} https://${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com && \
    docker pull ${var.pull_image} --quiet && \
    docker tag ${var.pull_image} ${var.push_image} && \
    docker push ${var.push_image} && \
    docker rmi ${var.push_image}
    EOT
  }
   triggers = {
    pull_image_sha256_digest    = data.docker_registry_image.pull_image.sha256_digest
    push_image_tag              = var.push_image
  }
  depends_on = [
    data.docker_registry_image.pull_image
  ]
}

data "aws_ecr_authorization_token" "docker_secret" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
