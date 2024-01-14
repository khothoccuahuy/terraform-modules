resource "aws_dynamodb_table" "this" {
  count = var.create_table && !var.autoscaling_enabled ? 1 : 0

  name                        = var.name
  billing_mode                = var.billing_mode
  hash_key                    = var.hash_key
  range_key                   = var.range_key
  read_capacity               = var.read_capacity
  write_capacity              = var.write_capacity
  stream_enabled              = var.stream_enabled
  stream_view_type            = var.stream_view_type
  table_class                 = var.table_class
  deletion_protection_enabled = var.deletion_protection_enabled

  dynamic "ttl" {
    for_each = var.ttl_enabled ? [0] : []
    content {
      enabled        = var.ttl_enabled
      attribute_name = var.ttl_attribute_name
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes

    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes

    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
    }
  }

  dynamic "replica" {
    for_each = var.replica_regions

    content {
      region_name            = replica.value.region_name
      kms_key_arn            = lookup(replica.value, "kms_key_arn", null)
      propagate_tags         = lookup(replica.value, "propagate_tags", null)
      point_in_time_recovery = lookup(replica.value, "point_in_time_recovery", null)
    }
  }

  server_side_encryption {
    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.server_side_encryption_kms_key_arn
  }

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.name)
    },
  )

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }
}

resource "aws_dynamodb_table" "autoscaled" {
  count = var.create_table && var.autoscaling_enabled && !var.ignore_changes_global_secondary_index ? 1 : 0

  name                        = var.name
  billing_mode                = var.billing_mode
  hash_key                    = var.hash_key
  range_key                   = var.range_key
  read_capacity               = var.read_capacity
  write_capacity              = var.write_capacity
  stream_enabled              = var.stream_enabled
  stream_view_type            = var.stream_view_type
  table_class                 = var.table_class
  deletion_protection_enabled = var.deletion_protection_enabled

  dynamic "ttl" {
    for_each = var.ttl_enabled ? [0] : []
    content {
      enabled        = var.ttl_enabled
      attribute_name = var.ttl_attribute_name
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes

    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes

    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
    }
  }

  dynamic "replica" {
    for_each = var.replica_regions

    content {
      region_name            = replica.value.region_name
      kms_key_arn            = lookup(replica.value, "kms_key_arn", null)
      propagate_tags         = lookup(replica.value, "propagate_tags", null)
      point_in_time_recovery = lookup(replica.value, "point_in_time_recovery", null)
    }
  }

  server_side_encryption {
    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.server_side_encryption_kms_key_arn
  }

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.name)
    },
  )

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }

  lifecycle {
    ignore_changes = [read_capacity, write_capacity]
  }
}


resource "aws_dynamodb_table" "autoscaled_gsi_ignore" {
  count = var.create_table && var.autoscaling_enabled && var.ignore_changes_global_secondary_index ? 1 : 0

  name                        = var.name
  billing_mode                = var.billing_mode
  hash_key                    = var.hash_key
  range_key                   = var.range_key
  read_capacity               = var.read_capacity
  write_capacity              = var.write_capacity
  stream_enabled              = var.stream_enabled
  stream_view_type            = var.stream_view_type
  table_class                 = var.table_class
  deletion_protection_enabled = var.deletion_protection_enabled

  dynamic "ttl" {
    for_each = var.ttl_enabled ? [0] : []
    content {
      enabled        = var.ttl_enabled
      attribute_name = var.ttl_attribute_name
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes

    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes

    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
    }
  }

  dynamic "replica" {
    for_each = var.replica_regions

    content {
      region_name            = replica.value.region_name
      kms_key_arn            = lookup(replica.value, "kms_key_arn", null)
      propagate_tags         = lookup(replica.value, "propagate_tags", null)
      point_in_time_recovery = lookup(replica.value, "point_in_time_recovery", null)
    }
  }

  server_side_encryption {
    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.server_side_encryption_kms_key_arn
  }

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.name)
    },
  )

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }

  lifecycle {
    ignore_changes = [global_secondary_index, read_capacity, write_capacity]
  }
}

data "null_data_source" "dynamodb_table_asg_target_name" {
  inputs = {
    table_name = !var.create_table ? var.name : var.autoscaling_enabled && var.ignore_changes_global_secondary_index ? aws_dynamodb_table.autoscaled_gsi_ignore[0].name : var.autoscaling_enabled ? aws_dynamodb_table.autoscaled[0].name : aws_dynamodb_table.this[0].name
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  count              = var.autoscaling_enabled ? 1 : 0
  max_capacity       = lookup(var.autoscaling_read, "max_capacity", 5)
  min_capacity       = lookup(var.autoscaling_read, "min_capacity", 1)
  resource_id        = "table/${data.null_data_source.dynamodb_table_asg_target_name.outputs["table_name"]}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  count              = var.autoscaling_enabled ? 1 : 0
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read_target[count.index].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_read_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_read_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_read_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = var.autoscaling_defaults.target_value
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
  count              = var.autoscaling_enabled ? 1 : 0
  max_capacity       = lookup(var.autoscaling_write, "max_capacity", 5)
  min_capacity       = lookup(var.autoscaling_write, "min_capacity", 1)
  resource_id        = "table/${data.null_data_source.dynamodb_table_asg_target_name.outputs["table_name"]}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_write_policy" {
  count              = var.autoscaling_enabled ? 1 : 0
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write_target[count.index].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_write_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_write_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_write_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = var.autoscaling_defaults.target_value
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_gsi_read_target" {
  count = var.autoscaling_enabled ? length(var.autoscaling_indexes) : 0
  max_capacity       = lookup(lookup(var.autoscaling_indexes[count.index], "autoscaling_read", {}), "max_capacity", 5)
  min_capacity       = lookup(lookup(var.autoscaling_indexes[count.index], "autoscaling_read", {}), "min_capacity", 1)
  resource_id        = "table/${data.null_data_source.dynamodb_table_asg_target_name.outputs["table_name"]}/index/${var.autoscaling_indexes[count.index].name}"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_gsi_read_policy" {
  count = var.autoscaling_enabled ? length(var.autoscaling_indexes) : 0
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_gsi_read_target[count.index].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_gsi_read_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_gsi_read_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_gsi_read_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = var.autoscaling_defaults.target_value
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_gsi_write_target" {
  count = var.autoscaling_enabled ? length(var.autoscaling_indexes) : 0
  max_capacity       = lookup(lookup(var.autoscaling_indexes[count.index], "autoscaling_write", {}), "max_capacity", 5)
  min_capacity       = lookup(lookup(var.autoscaling_indexes[count.index], "autoscaling_write", {}), "min_capacity", 1)
  resource_id        = "table/${data.null_data_source.dynamodb_table_asg_target_name.outputs["table_name"]}/index/${var.autoscaling_indexes[count.index].name}"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_gsi_write_policy" {
  count = var.autoscaling_enabled ? length(var.autoscaling_indexes) : 0
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_gsi_write_target[count.index].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_gsi_write_target[count.index].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_gsi_write_target[count.index].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_gsi_write_target[count.index].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = var.autoscaling_defaults.target_value
  }
}
