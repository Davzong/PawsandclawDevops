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
variable "workspace" {
  type        = string
  description = "Workspace name"
  default     = "UAT"
}
variable "vpc_id" {
  description = "The ID of the VPC to use"
  type        = string
}