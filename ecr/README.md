## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ecr\_image\_tag\_mutability | n/a | `string` | `"MUTABLE"` | no |
| ecr\_lifecycle\_policy\_count\_number | n/a | `number` | `1` | no |
| ecr\_lifecycle\_policy\_description | n/a | `string` | `"Only one untagged image will be in repo."` | no |
| ecr\_name | n/a | `string` | n/a | yes |
| ecr\_scan\_on\_push | n/a | `bool` | `true` | no |
| environment | n/a | `string` | n/a | yes |
| owner | n/a | `string` | n/a | yes |

## Outputs

No output.

