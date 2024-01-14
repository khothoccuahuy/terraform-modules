
resource "null_resource" "k8s_cluster_context" {
  provisioner "local-exec" {
    command = "aws eks --profile ${var.aws_profile} --region ${var.region} update-kubeconfig --kubeconfig ${var.kubeconfig_path} --name ${var.eks_cluster_name}"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
