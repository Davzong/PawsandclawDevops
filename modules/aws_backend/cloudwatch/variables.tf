variable "default_tags" {
  type = map(any)
  default = {
  }
}

variable "main_ecs_name" {
  description = "output main_ecs_name > aws_ecs_cluster.main_ecs.name"
}

variable "main_ecs_service_name" {
  description = "output main_ecs_service_name > aws_ecs_service_main_ecs_service.name"
}

variable "ecs_as_cpu_low_threshold_per" {
  description = "the number of containers will be reduced (but not below ecs_autoscale_min_instances)"
  type        = number
}

variable "ecs_as_cpu_high_threshold_per" {
  description = "If the average CPU utilization over a minute rises to this threshold,the number of containers will be increased (but not above ecs_autoscale_max_instances)."
  type        = number
}

variable "app_asg_up_arn" {
  description = "output app_asg_up_arn > aws_appautoscaling_policy.app_up.arn"
}

variable "app_asg_down_arn" {
  description = "output app_asg_up_arn > aws_appautoscaling_policy.app_down.arn"
}

variable "workspace" {
  description = "workspace environemtn"
}