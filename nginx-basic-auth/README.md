# Usage

For example you have service "KnoxGuard" with ingress and whant to secure it with Basic Auth.

1. Find terraform file with service defenition `terraform/shared-apps/svc_knoxguard_service.tf`

2. In this file create instance from module, like:

```hcl
module "svc_knoxguard_service_nginx_basic_auth" {
  count = var.environment == "alps-prod" ? 1 : 0
  source = "../../terraform-modules/aws/nginx-basic-auth"
  ssm_prefix = local.ssm_prefix # /alps-prod
  service_name = "knoxguard-service" # will be used in SSM parameters naming
}
```

3. In `module "svc_knoxguard_service"` find parameter `helm_values`
4. In parameter `helm_values` add next:

```hcl
    ingressInternal = {
      enabled             = true
      domain              = local.svc_knoxguard_app_internal_dns_name
      servicePort         = 80
      basicAuthSecretName = var.environment == "alps-prod" ? module.svc_knoxguard_service_nginx_basic_auth[0].k8s_secret_name : false
      tls = {
        enabled = true
      }
    }
```

Ready for deploy.

When deploy will done, you should find parameter `/alps-prod/knoxguard-service/ingress-password`, this will be your password for Ingress which was created/updated.
