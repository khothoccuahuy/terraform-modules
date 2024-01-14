variable "s3_endpoint_enable" {}

variable "vpc_id" {}

variable "region" {}

variable "endpoint_policy" {
  default     = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY
}

//variable "endpoint_db_policy" {
//  default     = <<POLICY
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Action": "*",
//            "Effect": "Allow",
//            "Resource": "*",
//            "Principal": "*"
//        }
//    ]
//}
//POLICY
//}

variable "security_group_id" {}

variable "subnet_ids" {}

variable "environment" {}

variable "owner" {}

variable "dynamo_db_endpoint_enable" {}

variable "route_tables" {}

variable "ec2_endpoint_enable" {}

variable "autoscaling_endpoint_enable" {}

variable "ecr_api_endpoint_enable" {}

variable "ecr_dkr_endpoint_enable" {}

variable "elasticloadbalancing_endpoint_enable" {}

variable "logs_endpoint_enable" {}

variable "sts_endpoint_enable" {}


variable "tags" {
  type    = map(string)
  default = {}
}
