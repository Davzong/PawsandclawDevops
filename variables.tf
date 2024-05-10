variable "cidr_block" {}
variable "prefix" {}
variable "availability_zones" {}
variable "app_count" {}


variable "alb_sg_id" {
  type    = list(string)
  default = []
}
