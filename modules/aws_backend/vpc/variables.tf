variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-southeast-2"
}

variable "workspace" {
  type        = string
  description = "Workspace name"
  default     = "UAT"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "az_count" {
  type        = number
  description = "Number of availability zones"
}

variable "health_check" {
  type        = string
  description = "Health check path"
}

variable "container_port" {
  type        = number
  description = "Container port"
}

variable "replicas" {
  type        = number
  description = "Number of replicas"
}

variable "container_name" {
  type        = string
  description = "Name of the container"
}

variable "default_backend_image" {
  type        = string
  description = "Default Docker image URL"
}

variable "fargate_cpu" {
  type        = number
  description = "Fargate CPU units"
}

variable "fargate_memory" {
  type        = number
  description = "Fargate memory in MiB"
}

variable "alb_ssl_cert_arn" {
  type        = string
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags for resources"
  default = {
    Environment = "UAT"
    Project     = "Paws-and-claws"
  }
}

# Security Group variables
variable "lb_sg_id" {
  type        = string
  description = "Security group ID for the load balancer"
  default     = "sg-0123456789abcdef0" # Replace with your actual lb_sg_id
}

variable "ecs_sg_id" {
  type        = string
  description = "Security group ID for ECS"
  default     = "sg-0123456789abcdef1" # Replace with your actual ecs_sg_id
}

# Subnet variables
variable "lb_subnet_id" {
  type        = list(string)
  description = "List of subnet IDs for the load balancer"
  default     = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1"] # Replace with your actual lb_subnet_ids
}

variable "ecs_subnet_id" {
  type        = list(string)
  description = "List of subnet IDs for ECS"
  default     = ["subnet-0123456789abcdef2", "subnet-0123456789abcdef3"] # Replace with your actual ecs_subnet_ids
}

# IAM Role variables
variable "ecsTaskExecutionRole_arn" {
  type        = string
  description = "ARN of the IAM role for ECS task execution"
  default     = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
}

# Common tags
variable "common_tags" {
  type        = map(string)
  description = "Common tags for resources"
  default     = {
    Environment = "UAT"
    Project     = "Paws-and-claws"
  }
}
