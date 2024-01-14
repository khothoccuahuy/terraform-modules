## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | n/a | `string` | n/a | yes |
| ingress\_cidr\_blocks\_map\_list | Can be specified multiple times for each ingress rule. | <pre>list(object({<br>    from_port   = number<br>    protocol    = string<br>    to_port     = number<br>    cidr_blocks = list(string)<br>    self        = bool<br>  }))</pre> | `[]` | no |
| ingress\_sg\_map\_list | Can be specified multiple times for each ingress rule. | <pre>list(object({<br>    from_port                = number<br>    protocol                 = string<br>    to_port                  = number<br>    source_security_group_id = string<br>  }))</pre> | `[]` | no |
| ingress\_with\_cidr\_blocks | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | `[]` | no |
| owner | n/a | `string` | n/a | yes |
| security\_group\_description | n/a | `string` | `"Default Security Group"` | no |
| security\_group\_name | n/a | `string` | n/a | yes |
| vpc\_id | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_arn | Security Group ARN |
| security\_group\_id | Security Group ID |
| security\_group\_name | Security Group name |

