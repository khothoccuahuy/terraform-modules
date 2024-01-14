## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias\_configuration | Object with alias parameters | <pre>list(object({<br>    name                   = string<br>    zone_id                = string<br>    evaluate_target_health = bool<br>  }))</pre> | `[]` | no |
| record\_name | n/a | `string` | n/a | yes |
| record\_target | n/a | `list(string)` | `[]` | no |
| record\_ttl | n/a | `string` | `60` | no |
| record\_type | n/a | `string` | n/a | yes |
| zone\_id | n/a | `string` | n/a | yes |
| zone\_name | n/a | `string` | n/a | yes |

## Outputs

No output.

