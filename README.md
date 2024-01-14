# Modules of terraform aws developed by me - Infrastructure

Terraform modules

Contains:

- All the infrastructure related Terraform modules, configs, envs.

You can find README file in each folder to undestand how to use which they contain.

## Structure

```
.
├── acm-certificate
├── alb
├── appsync
├── autoScalingGroup
├── backup
├── cloudfront
├── cloudfront-distribution-appsync
├── cloudfront-distribution-s3
├── ...
├── vpc-elastics-ip-association
└── waf
```

## Usage

Copy and paste into your Terraform configuration, insert or update the variables, and run `terraform init`:

```terraform
module my_module {
  source = "git@github.com:khothoccuahuy/terraform-modules.git//`<some-module>`?ref=master"
  service_name = "my-service"
  environment = "production"
  responsible_party = "joe"
  vcs = "/path/to/some/git/repo"
}
```
