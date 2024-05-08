
variable "health_check" {
  description = "Path to check if the service is healthy, e.g. \"/status\""
}

variable "default_tags" {
  type = map(any)
  default = {
  }
}

variable "container_port" {
  description = "Container Port where application is exposed"
}

variable "vpc_id" {
  description = "output vpc_id value > aws_vpc.main_vpc.id"

}

variable "lb_sg_id" {
  description = "output aws_security_groups > [aws_security_group.lb_sg.id]"
}

variable "lb_subnet_id" {
  description = "output aws_subnets > aws_subnet.lb_subnet.*.id"
}


variable "workspace" {
  description = "workspace environemtn"
}