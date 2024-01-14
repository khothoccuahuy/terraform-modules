# Terraform Modules of AWS

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
provider "aws" {
  region  = "eu-west-1"
}

provider "aws" {
  region  = "us-east-1"
  alias   = "certificates"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.3.7"
}

module "eks_vpc" {
  source                   = "git@github.com:khothoccuahuy/terraform-modules.git//network/vpc?ref=master"
  environment              = "dev"
  vpc_cidr_block           = "10.3.2.0/24"
  vpc_enable_dns_hostnames = true
  vpc_enable_dns_support   = true
  vpc_instance_tenancy     = "default"
  vpc_name                 = "khothoccuahuy-dev-VPC"
  tags = {
    "kubernetes.io/cluster/khothoccuahuy-dev-cluster" = "shared"
  }
}
```
