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

resource "aws_cloudwatch_metric_alarm" "web_cpu" {
  alarm_name          = "${var.project_name}-web-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Web server CPU utilization is high"
  alarm_actions             = [aws_sns_topic.alerts.arn]
  ok_actions                = [aws_sns_topic.alerts.arn]
  insufficient_data_actions = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = aws_instance.web.id
  }

  tags = {
    Name        = "${var.project_name}-web-cpu-high"
    Environment = var.environment
  }
}

resource "aws_sns_topic" "scenario_6_test_create_no_related" {
  name = "scenario-6-test-create-no-related"
}
