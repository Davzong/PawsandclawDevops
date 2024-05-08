variable "region" {
  type = string
}

variable "health_check" {
  description = "Path to check if the service is healthy, e.g. \"/status\""
}

variable "default_tags" {
  type = map(any)
  default = {
  }
}

variable "replicas" {
  description = "desired count number"
}

variable "container_name" {
  description = "The name of the container to run"
}

variable "default_backend_image" {
  description = "default Docker image Replace with your actual image"
}


variable "container_port" {
  description = "Container Port where application is exposed"
}

variable "fargate_cpu" {
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "ecs_sg_id" {
  description = "output ecs_sg_id > aws_security_group.ecs_sg.id"
}

variable "ecs_subnet_id" {
  description = "output ecs_subnet_id > aws_subnet.ecs_subnet.*.id"
}

variable "main_alb_tg_id" {
  description = "output main_alb_tg_id > aws_alb_target_group.main_alb_tg.id"
}

variable "alb_listener_http" {
  description = "output alb_listener_http > aws_alb_listener.listener_http"
}

variable "ecsTaskExecutionRole_arn" {
  description = "output ecsTaskExecutionrole > aws_iam_role.ecsTaskExecutionRole.arn"
}



variable "workspace" {
  description = "workspace environemtn"
}