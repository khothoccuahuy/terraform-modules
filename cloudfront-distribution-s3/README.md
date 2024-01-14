## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.certificates | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acl | (Optional) The canned ACL to apply. Defaults to 'private'. | `any` | `null` | no |
| certificate\_domain | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_aliases | n/a | `list(string)` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_allowed\_methods | n/a | `list(string)` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_cached\_methods | n/a | `list(string)` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_compress | n/a | `bool` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_cookies\_forward | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_default\_ttl | n/a | `number` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_max\_ttl | n/a | `number` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_min\_ttl | n/a | `number` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_protocol\_policy | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_query\_string | n/a | `bool` | n/a | yes |
| cloudfront\_distribution\_default\_cache\_behavior\_target\_origin\_id | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_default\_root\_object | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_enable | n/a | `bool` | n/a | yes |
| cloudfront\_distribution\_ipv6\_enable | n/a | `bool` | n/a | yes |
| cloudfront\_distribution\_minimum\_protocol\_version | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_origin\_id | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_price\_class | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_restriction\_type | n/a | `string` | n/a | yes |
| cloudfront\_distribution\_ssl\_support\_method | n/a | `string` | n/a | yes |
| dns\_record | n/a | `string` | n/a | yes |
| environment | n/a | `string` | n/a | yes |
| evaluate\_target\_health | n/a | `bool` | n/a | yes |
| inputs\_error\_responses | n/a | <pre>list(object({<br>    error_caching_min_ttl = number<br>    error_code            = number<br>    response_code         = number<br>    response_page_path    = string<br>    })<br>  )</pre> | n/a | yes |
| origin\_access\_identity\_comment | n/a | `string` | n/a | yes |
| record\_type | n/a | `string` | n/a | yes |
| s3\_bucket\_force\_destroy | n/a | `bool` | n/a | yes |
| s3\_bucket\_name | n/a | `string` | n/a | yes |
| website\_configuration | Website index document | `list(map(string))` | `[]` | no |
| zone\_id | n/a | `string` | n/a | yes |

## Outputs

No output.

