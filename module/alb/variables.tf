variable "prefix" {}
variable "vpc_id" {}
variable "public_subnet_id" {}

variable "health_check_path" {
  default = "/"
}

variable "alb_sg_id" {
  type    = list(string)
  default = []
}