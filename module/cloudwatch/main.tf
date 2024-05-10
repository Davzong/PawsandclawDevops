resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name                = "high-cpu-usage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ecs cpu usage"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.alerts.arn]
  dimensions = {
    ClusterName = var.app_cluster.name
    ServiceName = var.app_service.name
  }
}

resource "aws_sns_topic" "alerts" {
  name = "${var.prefix}alert-topic"
}
