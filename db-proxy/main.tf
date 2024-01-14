##################################################################################
/* https://github.com/terraform-aws-modules/terraform-aws-rds-proxy/tree/v3.0.0 */
##################################################################################

data "aws_region" "current" {}
data "aws_partition" "current" {}

################################################################################
# RDS Proxy
################################################################################

resource "aws_db_proxy" "this" {
  count = var.create ? 1 : 0

  dynamic "auth" {
    for_each = var.auth

    content {
      auth_scheme               = try(auth.value.auth_scheme, "SECRETS")
      client_password_auth_type = try(auth.value.client_password_auth_type, null)
      description               = try(auth.value.description, null)
      iam_auth                  = try(auth.value.iam_auth, null)
      secret_arn                = try(auth.value.secret_arn, null)
      username                  = try(auth.value.username, null)
    }
  }

  debug_logging          = var.debug_logging
  engine_family          = var.engine_family
  idle_client_timeout    = var.idle_client_timeout
  name                   = var.name
  require_tls            = var.require_tls
  role_arn               = var.role_arn
  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_subnet_ids         = var.vpc_subnet_ids

  tags = merge(var.tags, var.proxy_tags)
}

resource "aws_db_proxy_default_target_group" "this" {
  count = var.create ? 1 : 0

  db_proxy_name = aws_db_proxy.this[0].name

  connection_pool_config {
    connection_borrow_timeout    = var.connection_borrow_timeout
    init_query                   = var.init_query
    max_connections_percent      = var.max_connections_percent
    max_idle_connections_percent = var.max_idle_connections_percent
    session_pinning_filters      = var.session_pinning_filters
  }
}

resource "aws_db_proxy_target" "db_instance" {
  count = var.create && var.target_db_cluster ? 0 : 1

  db_proxy_name          = aws_db_proxy.this[0].name
  target_group_name      = aws_db_proxy_default_target_group.this[0].name
  db_instance_identifier = var.db_identifier
}

resource "aws_db_proxy_target" "db_cluster" {
  count = var.create && var.target_db_cluster ? 1 : 0

  db_proxy_name         = aws_db_proxy.this[0].name
  target_group_name     = aws_db_proxy_default_target_group.this[0].name
  db_cluster_identifier = var.db_identifier
}

resource "aws_db_proxy_endpoint" "this" {
  for_each = { for k, v in var.endpoints : k => v if var.create }

  db_proxy_name          = aws_db_proxy.this[0].name
  db_proxy_endpoint_name = each.value.name
  vpc_subnet_ids         = each.value.vpc_subnet_ids
  vpc_security_group_ids = lookup(each.value, "vpc_security_group_ids", null)
  target_role            = lookup(each.value, "target_role", null)

  tags = lookup(each.value, "tags", var.tags)
}