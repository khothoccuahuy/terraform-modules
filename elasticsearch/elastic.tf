resource "aws_elasticsearch_domain" "elasticsearch" {
  domain_name           = trim(substr(var.domain_name,0,28),"-")
  elasticsearch_version = var.elasticsearch_version
  access_policies       = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "es:*",
          "Principal": {
              "AWS" : "*"
          },
          "Effect": "Allow",
          "Resource" : "arn:aws:es:${var.region}:${var.account_id}:domain/${trim(substr(var.domain_name,0,28),"-")}/*",
          "Condition": {
            "StringNotEquals": {
              "aws:group": [
                "${var.environment}-tam"
              ]
            }
          }
        },
        {
          "Action": "es:HttpGet",
          "Principal": {
              "AWS" : "*"
          },
          "Effect": "Allow",
          "Resource" : "arn:aws:es:${var.region}:${var.account_id}:domain/${trim(substr(var.domain_name,0,28),"-")}/*",
          "Condition": {
            "StringEquals": {
              "aws:group": [
                "${var.environment}-tam"
              ]
            }
          }
        }
      ]
    }
  POLICY

  advanced_options = var.advanced_options

  cluster_config {
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_type    = var.dedicated_master_type
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    zone_awareness_enabled   = var.zone_awareness_enabled
    zone_awareness_config {
      availability_zone_count = var.zone_awareness_config_availability_zone_count
    }

  }



  ebs_options {
    ebs_enabled = var.ebs_options.ebs_enabled
    iops        = var.ebs_options.iops
    volume_size = var.ebs_options.volume_size
    volume_type = var.ebs_options.volume_type
  }

  encrypt_at_rest {
    enabled    = var.encrypt_at_rest_enabled
    kms_key_id = var.kms_key_id
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption_enabled
  }

  snapshot_options {
    automated_snapshot_start_hour = var.snapshot_options_automated_snapshot_start_hour
  }

  vpc_options {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
  tags = merge({
    Team        = "Alps-DevOps"
    Domain      = var.domain_name
    Environment = var.environment
    Terraform   = "true"
  }, var.tags)

  lifecycle {
    ignore_changes = [
      advanced_options
    ]
  }


  depends_on = [aws_iam_service_linked_role.es]
}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}