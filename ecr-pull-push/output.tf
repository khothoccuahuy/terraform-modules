output "pull_image_sha256_digest" {
  value = data.docker_registry_image.pull_image.sha256_digest
}
