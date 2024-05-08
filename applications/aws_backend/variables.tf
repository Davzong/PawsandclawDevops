variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Range of CIDR max(16)"
  type        = map(string)
}

variable "region" {
  type = map(string)
}

variable "az_count" {
  type = map(number)
}

variable "default_tags" {
  type = map(any)
}

variable "health_check" {
  description = "Path to check if the service is healthy, e.g. \"/status\""
  type        = map(string)
}

variable "container_port" {
  description = "Container Port where application is exposed"
  type        = map(number)
}

variable "replicas" {
  description = "desired count number"
  type        = map(number)
}

variable "container_name" {
  description = "The name of the container to run"
  type        = map(string)
}

variable "fargate_cpu" {
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
  type        = map(number)
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB) not MB"
  type        = map(number)
}

variable "ecs_as_cpu_low_threshold_per" {
  description = "the number of containers will be reduced (but not below ecs_autoscale_min_instances)"
  type        = map(number)
}

variable "ecs_as_cpu_high_threshold_per" {
  description = "If the average CPU utilization over a minute rises to this threshold,the number of containers will be increased (but not above ecs_autoscale_max_instances)."
  type        = map(number)
}

variable "scale_up_cron" {
  type = map(string)
}

variable "scale_down_cron" {
  description = "Default scale down at 7 pm every day"
  type        = map(string)
}

variable "scale_down_min_capacity" {
  description = "The mimimum number of containers to scale down to.Set this and `scale_down_max_capacity` to 0 to turn off service on the `scale_down_cron` schedule."
  type        = map(number)
}

variable "scale_down_max_capacity" {
  description = "The maximum number of containers to scale down to."
  type        = map(number)
}

variable "app_asg_up_arn" {
  description = "ARN for scaling up in Auto Scaling Group"
  type        = string
}

variable "app_asg_down_arn" {
  description = "ARN for scaling down in Auto Scaling Group"
  type        = string
}





variable "zone_id" {
  description = "Hosted zones ID"
  type        = map(string)
}

variable "workspace" {
  description = "workspace environemtn"
  type        = map(string)
}



