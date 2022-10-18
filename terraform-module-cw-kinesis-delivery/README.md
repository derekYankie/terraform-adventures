## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_stream.cw_metric_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_stream) | resource |
| [aws_iam_role.cw_firehose_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.kinesis_firehose_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.kinesis_streams_settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kinesis_firehose_delivery_stream.destination](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_s3_bucket.kinesis_failed_streams_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_iam_policy_document.cw_firehose_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kinesis_firehose_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.kinesis_streams_settings](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Application name/type - part of naming convention to apply. | `string` | n/a | yes |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS account ID where the OIDC provider lives, leave empty to use the account for the AWS provider | `string` | n/a | yes |
| <a name="input_destinantion_firehose_endpoint"></a> [destinantion\_firehose\_endpoint](#input\_destinantion\_firehose\_endpoint) | Destination HTTP Endpoint URL | `string` | n/a | yes |
| <a name="input_http_access_key"></a> [http\_access\_key](#input\_http\_access\_key) | This the destination API Key | `string` | n/a | yes |
| <a name="input_http_endpoint_buffering_interval"></a> [http\_endpoint\_buffering\_interval](#input\_http\_endpoint\_buffering\_interval) | Kinesis Firehose buffer interval in seconds | `number` | `60` | no |
| <a name="input_http_endpoint_buffering_size"></a> [http\_endpoint\_buffering\_size](#input\_http\_endpoint\_buffering\_size) | Kinesis Firehose buffer size in MB | `number` | `4` | no |
| <a name="input_http_endpoint_retry_duration"></a> [http\_endpoint\_retry\_duration](#input\_http\_endpoint\_retry\_duration) | Kinesis Firehose stream retry in seconds | `number` | `60` | no |
| <a name="input_kinesis_lg_retention_in_days"></a> [kinesis\_lg\_retention\_in\_days](#input\_kinesis\_lg\_retention\_in\_days) | Kinesis log group retention time in days | `number` | `7` | no |
| <a name="input_log_group_names"></a> [log\_group\_names](#input\_log\_group\_names) | List of log groups to subscribe to with the log filter | `list(string)` | `[]` | no |
| <a name="input_output_format"></a> [output\_format](#input\_output\_format) | CloudWatch metric stream output format | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Kinesis delivery stream prefix. | `string` | `"dt"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region | `string` | n/a | yes |
| <a name="input_s3_buffer_interval"></a> [s3\_buffer\_interval](#input\_s3\_buffer\_interval) | S3 buffer interval in seconds | `number` | `300` | no |
| <a name="input_s3_buffer_size"></a> [s3\_buffer\_size](#input\_s3\_buffer\_size) | S3 buffer size in MB | `number` | `5` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_metric_stream"></a> [cloudwatch\_metric\_stream](#output\_cloudwatch\_metric\_stream) | CloudWatch metric stream |
| <a name="output_kinesis_delivery_stream"></a> [kinesis\_delivery\_stream](#output\_kinesis\_delivery\_stream) | Kinesis Delivery stream |
| <a name="output_metric_format"></a> [metric\_format](#output\_metric\_format) | Metric format |
