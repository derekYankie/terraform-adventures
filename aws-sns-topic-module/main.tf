resource "aws_sns_topic" "topic" {
  name = "my-sns-topic"

  tags = {
    Name = "${var.prefix}-${var.aws-profile}-sns-topic"
  }
}
