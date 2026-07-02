resource "aws_sns_topic" "alerts" {
  name         = "${var.project_name}-alerts"
  display_name = var.sns_display_name

  tags = {
    Name        = "${var.project_name}-alerts"
    Environment = var.environment
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}
