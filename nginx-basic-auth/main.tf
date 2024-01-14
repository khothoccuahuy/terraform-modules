module "ssm_login" {
  source = "../ssm-parameter"
  description = "${var.service_name} ingress login"
  name  = "/${var.ssm_prefix}/${var.service_name}/ingress-login"
  tags  = var.tags
  type  = "String"
  value = "admin"
}

module "ssm_password" {
  source = "../ssm-parameter-random-password"
  description = "${var.service_name} ingress password"
  name  = "/${var.ssm_prefix}/${var.service_name}/ingress-password"
  tags  = var.tags
}

resource "kubernetes_secret" "ingress_secret" {
  metadata {
    name = "${var.service_name}-ingress-password"
    namespace = var.apps_shared_namespace
  }

  data = {
    auth = "${module.ssm_login.value}:${bcrypt(module.ssm_password.value)}"
  }

  depends_on = [module.ssm_login, module.ssm_password]
}