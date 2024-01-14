output "k8s_secret_name" {
  value = kubernetes_secret.ingress_secret.metadata[0].name
}
