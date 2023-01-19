<!-- BEGIN_TF_DOCS -->
![image](https://user-images.githubusercontent.com/18011667/202057364-579f4045-3c2f-48f3-8307-7789166ab5b0.png)
#### Table of Contents
1. [Usage](#usage)
2. [Requirements](#requirements)
3. [Providers](#Providers)
4. [Inputs](#inputs)
5. [Outputs](#outputs)

## Usage
### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_sns_topic.topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws-profile"></a> [aws-profile](#input\_aws-profile) | IAM User | `string` | `"default"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | SNS Topic prefix | `string` | `"demo"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_sns_topic_name"></a> [aws\_sns\_topic\_name](#output\_aws\_sns\_topic\_name) | The name of the bucket. |
<!-- END_TF_DOCS -->