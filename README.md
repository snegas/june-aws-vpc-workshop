# june-aws-vpc-workshop
In this repo you're going to find a VPC and underlying resources creation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| enable\_dns\_hostnames | Enable/disable DNS Hostnames in the VPC | `bool` | `false` | no |
| enable\_dns\_support | Enable/disable DNS Support in the VPC | `bool` | `true` | no |
| enable\_vpc | Create VPC or not? | `bool` | `true` | no |
| prefix | Prefix to all resources in the module | `string` | n/a | yes |
| tags | Tags which are going to be attached to all resources | `map(string)` | `{}` | no |
| vpc\_cidr | Valid AWS VPC CIDR block | `string` | n/a | yes |
| vpc\_tags | Tags which are going to be attached to VPC resource only | `map(string)` | `{}` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->