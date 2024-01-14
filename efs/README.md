## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| efs\_encrypted | If true, the file system will be encrypted | `bool` | `false` | no |
| efs\_kms\_key\_id | If set, use a specific KMS key | `string` | `null` | no |
| efs\_name | n/a | `string` | n/a | yes |
| efs\_performance\_mode | The file system performance mode. Can be either `generalPurpose` or `maxIO` | `string` | `"generalPurpose"` | no |
| efs\_provisioned\_throughput\_in\_mibps | The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with `throughput_mode` set to provisioned | `number` | `0` | no |
| efs\_security\_group\_id | n/a | `string` | n/a | yes |
| efs\_throughput\_mode | Throughput mode for the file system. Defaults to bursting. Valid values: `bursting`, `provisioned`. When using `provisioned`, also set `provisioned_throughput_in_mibps` | `string` | `"bursting"` | no |
| efs\_transition\_to\_ia | Indicates how long it takes to transition files to the IA storage class. Valid values: AFTER\_7\_DAYS, AFTER\_14\_DAYS, AFTER\_30\_DAYS, AFTER\_60\_DAYS and AFTER\_90\_DAYS | `string` | `""` | no |
| environment | n/a | `string` | n/a | yes |
| owner | n/a | `string` | n/a | yes |
| subnet\_ids | Subnet IDs | `list(string)` | n/a | yes |
| vpc\_id | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | EFS ARN |
| dns\_name | EFS DNS name |
| id | EFS ID |
| mount\_target\_ids | List of EFS mount target IDs (one per Availability Zone) |

