# scale up alarm
resource "aws_autoscaling_policy" "glovo-cpu-policy" {
name = "glovo-cpu-policy"
autoscaling_group_name = "${aws_autoscaling_group.glovo-autoscaling.name}"
adjustment_type = "ChangeInCapacity"
scaling_adjustment = "1"
cooldown = "300"
policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "glovo-cpu-alarm" {
alarm_name = "glovo-cpu-alarm"
alarm_description = "glovo-cpu-alarm"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "120"
statistic = "Average"
threshold = "30"
dimensions = {
"AutoScalingGroupName" = "${aws_autoscaling_group.glovo-autoscaling.name}"
}
actions_enabled = true
alarm_actions = ["${aws_autoscaling_policy.glovo-cpu-policy.arn}"]
}
# scale down alarm
resource "aws_autoscaling_policy" "glovo-cpu-policy-scaledown" {
name = "glovo-cpu-policy-scaledown"
autoscaling_group_name = "${aws_autoscaling_group.glovo-autoscaling.name}"
adjustment_type = "ChangeInCapacity"
scaling_adjustment = "-1"
cooldown = "300"
policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "glovo-cpu-alarm-scaledown" {
alarm_name = "glovo-cpu-alarm-scaledown"
alarm_description = "glovo-cpu-alarm-scaledown"
comparison_operator = "LessThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "120"
statistic = "Average"
threshold = "5"
dimensions = {
"AutoScalingGroupName" = "${aws_autoscaling_group.glovo-autoscaling.name}"
}
actions_enabled = true
alarm_actions = ["${aws_autoscaling_policy.glovo-cpu-policy-scaledown.arn}"]
}
