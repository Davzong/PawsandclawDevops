variable "app_image" {}
variable "app_port" {}
variable "fargate_cpu" {}
variable "fargate_memory" {}
variable "aws_region" {}
variable "app_count" {}


variable "aws_iam_role_ecs_auto_scale_role" {}
variable "aws_subnet_private" {}
variable "aws_alb_target_group_app_id" {}
variable "aws_security_group_ecs_tasks_id" {}
variable "aws_alb_listener_front_end" {}
variable "aws_iam_role_policy_attachment_ecs_task_execution_role_policy_attachment" {}
variable "aws_iam_role_ecs_task_execution_role" {}
